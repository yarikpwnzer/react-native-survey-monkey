
package com.surveymonkey;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.surveymonkey.surveymonkeyandroidsdk.SurveyMonkey;
import com.surveymonkey.surveymonkeyandroidsdk.utils.SMError;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

public class RNSurveyMonkeyModule extends ReactContextBaseJavaModule {

    private static final int REQUEST_CODE = 103;

    private final SurveyMonkey surveyMonkey;

    private Promise resultPromise;

    public RNSurveyMonkeyModule(ReactApplicationContext reactContext) {
        super(reactContext);
        reactContext.addActivityEventListener(activityEventListener);
        surveyMonkey = new SurveyMonkey();
    }

    @Override
    public String getName() {
        return "RNSurveyMonkey";
    }

    @ReactMethod
    public void presentSurveyMonkey(final String surveyHash,
                                    final ReadableMap customVariables,
                                    final String scheduleInterceptTitle,
                                    final ReadableMap scheduleInterceptParams,
                                    final Promise promise) {
        final Activity activity = getCurrentActivity();
        if (activity == null)
            return;

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                JSONObject variables = null;
                try {
                    variables = MapUtil.toJSONObject(customVariables);
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                if (!TextUtils.isEmpty(scheduleInterceptTitle)) {
                    scheduleInterceptWithTitle(scheduleInterceptTitle, surveyHash, variables);
                    resolvePromise(Arguments.createMap());
                } else if (scheduleInterceptParams != null) {
                    scheduleInterceptWithParams(surveyHash, scheduleInterceptParams, variables);
                    resolvePromise(Arguments.createMap());
                } else {
                    resultPromise = promise;
                    presentSurveyMonkey(surveyHash, variables);
                }
            }
        });
    }

    private void presentSurveyMonkey(final String surveyHash, final JSONObject customVariables) {
        final Activity activity = getCurrentActivity();
        if (activity == null)
            return;

        surveyMonkey.startSMFeedbackActivityForResult(
                activity,
                REQUEST_CODE,
                surveyHash,
                customVariables
        );
    }

    private void scheduleInterceptWithTitle(final String title, final String surveyHash, final JSONObject customVariables) {
        final Activity activity = getCurrentActivity();
        if (activity == null)
            return;

        surveyMonkey.onStart(
                activity,
                title,
                REQUEST_CODE,
                surveyHash,
                customVariables
        );
    }

    private void scheduleInterceptWithParams(final String surveyHash, final ReadableMap scheduleInterceptParams, JSONObject customVariables) {
        final Activity activity = getCurrentActivity();
        if (activity == null)
            return;


        surveyMonkey.onStart(
                activity,
                REQUEST_CODE,
                surveyHash,
                scheduleInterceptParams.getString("title"),
                scheduleInterceptParams.getString("body"),
                fromDouble(scheduleInterceptParams.getDouble("afterInstallInterval")),
                fromDouble(scheduleInterceptParams.getDouble("afterDeclineInterval")),
                fromDouble(scheduleInterceptParams.getDouble("afterAcceptInterval")),
                customVariables
        );
    }

    private long fromDouble(double number) {
        return Double.valueOf(number).longValue();
    }

    private void resolvePromise(final WritableMap response) {
        if (resultPromise != null) {
            resultPromise.resolve(response);
        }
    }

    private void surveyMonkeySuccess(final String success) {
        try {
            JSONObject json = new JSONObject(success);
            Map<String, Object> map = MapUtil.toMap(json);
            WritableMap response = Arguments.createMap();
            response.putMap("respondent", MapUtil.toWritableMap(map));
            resolvePromise(response);
        } catch (JSONException e) {
            e.printStackTrace();
            if (resultPromise != null) {
                resultPromise.reject(e);
            }
        }

        resultPromise = null;
    }

    private void surveyMonkeyError(final SMError error) {
        if (error == null)
            return;

        WritableMap errorMap = Arguments.createMap();
        errorMap.putInt("code", error.errorCode);
        errorMap.putString("description", error.getException() != null ? error.getException().getLocalizedMessage() : null);
        errorMap.putString("fullDescription", error.description);

        WritableMap response = Arguments.createMap();
        response.putMap("error", errorMap);

        resolvePromise(response);
        resultPromise = null;
    }

    private final ActivityEventListener activityEventListener = new ActivityEventListener() {
        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
            if (requestCode != REQUEST_CODE || resultCode == Activity.RESULT_CANCELED || data == null)
                return;

            if (resultCode == Activity.RESULT_OK) {
                String respondent = data.getStringExtra("smRespondent");
                surveyMonkeySuccess(respondent);
            } else {
                SMError e = (SMError) data.getSerializableExtra("smError");
                surveyMonkeyError(e);
            }
        }

        @Override
        public void onNewIntent(Intent intent) {

        }
    };
}
