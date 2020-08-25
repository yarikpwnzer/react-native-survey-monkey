package com.surveymonkey;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableType;
import com.facebook.react.bridge.WritableArray;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

/**
 * Created by
 * rMozes on 2019-12-03.
 */
class ArrayUtil {


    static JSONArray toJSONArray(ReadableArray readableArray) throws JSONException {
        JSONArray jsonArray = new JSONArray();
        if (readableArray == null)
            return jsonArray;

        for (int i = 0; i < readableArray.size(); i++) {
            ReadableType type = readableArray.getType(i);

            switch (type) {
                case Null:
                    jsonArray.put(i, null);
                    break;
                case Boolean:
                    jsonArray.put(i, readableArray.getBoolean(i));
                    break;
                case Number:
                    jsonArray.put(i, readableArray.getDouble(i));
                    break;
                case String:
                    jsonArray.put(i, readableArray.getString(i));
                    break;
                case Map:
                    jsonArray.put(i, MapUtil.toJSONObject(readableArray.getMap(i)));
                    break;
                case Array:
                    jsonArray.put(i, ArrayUtil.toJSONArray(readableArray.getArray(i)));
                    break;
            }
        }

        return jsonArray;
    }

    static Object[] toArray(JSONArray jsonArray) throws JSONException {
        if (jsonArray == null)
            return new Object[0];
        Object[] array = new Object[jsonArray.length()];

        for (int i = 0; i < jsonArray.length(); i++) {
            Object value = jsonArray.get(i);

            if (value instanceof JSONObject) {
                value = MapUtil.toMap((JSONObject) value);
            }
            if (value instanceof JSONArray) {
                value = ArrayUtil.toArray((JSONArray) value);
            }

            array[i] = value;
        }

        return array;
    }

    static Object[] toArray(ReadableArray readableArray) {
        if (readableArray == null)
            return new Object[0];

        Object[] array = new Object[readableArray.size()];

        for (int i = 0; i < readableArray.size(); i++) {
            ReadableType type = readableArray.getType(i);

            switch (type) {
                case Null:
                    array[i] = null;
                    break;
                case Boolean:
                    array[i] = readableArray.getBoolean(i);
                    break;
                case Number:
                    array[i] = readableArray.getDouble(i);
                    break;
                case String:
                    array[i] = readableArray.getString(i);
                    break;
                case Map:
                    array[i] = MapUtil.toMap(readableArray.getMap(i));
                    break;
                case Array:
                    array[i] = ArrayUtil.toArray(readableArray.getArray(i));
                    break;
            }
        }

        return array;
    }

    static WritableArray toWritableArray(Object[] array) {
        WritableArray writableArray = Arguments.createArray();
        if (array == null)
            return writableArray;

        for (Object value : array) {
            if (value == null) {
                writableArray.pushNull();
            }
            if (value instanceof Boolean) {
                writableArray.pushBoolean((Boolean) value);
            }
            if (value instanceof Double) {
                writableArray.pushDouble((Double) value);
            }
            if (value instanceof Integer) {
                writableArray.pushInt((Integer) value);
            }
            if (value instanceof String) {
                writableArray.pushString((String) value);
            }
            if (value instanceof Map) {
                writableArray.pushMap(MapUtil.toWritableMap((Map<String, Object>) value));
            }
            if (value != null && value.getClass().isArray()) {
                writableArray.pushArray(ArrayUtil.toWritableArray((Object[]) value));
            }
        }

        return writableArray;
    }
}
