import React, { PureComponent } from "react";
import { NativeModules, View } from "react-native";
import PropTypes from "prop-types";

export default class SurveyMonkey extends PureComponent {
  static propTypes = {
    onRespondentDidEndSurvey: PropTypes.func
  };

  static defaultProps = {
    onRespondentDidEndSurvey: null
  };

  constructor(props) {
    super(props);

    this.showSurveyMonkey = this.showSurveyMonkey.bind(this);
  }

  showSurveyMonkey(
    survey,
    customVariables,
    scheduleInterceptTitle,
    scheduleInterceptParams
  ) {
    const { onRespondentDidEndSurvey } = this.props;
    NativeModules.RNSurveyMonkey.presentSurveyMonkey(
      survey,
      customVariables,
      scheduleInterceptTitle,
      scheduleInterceptParams
    ).then(response => {
      if (onRespondentDidEndSurvey) {
        onRespondentDidEndSurvey(response);
      }
    });
  }

  render() {
    return <View />;
  }
}
