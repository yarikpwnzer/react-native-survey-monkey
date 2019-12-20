
import React, { PureComponent } from 'react';
import {
  requireNativeComponent,
  UIManager,
  findNodeHandle
} from 'react-native';
import PropTypes from 'prop-types';

const RNMonkeyView = requireNativeComponent('RNSurveyMonkeyView');

export default class SurveyMonkey extends PureComponent {
  static propTypes = {
    onRespondentDidEndSurvey: PropTypes.func,
    cancelButtonTintColor: PropTypes.string
  };

  static defaultProps = {
    onRespondentDidEndSurvey: null,
    cancelButtonTintColor: null
  }

  constructor(props) {
    super(props);

    this.showSurveyMonkey = this.showSurveyMonkey.bind(this);
  }

  showSurveyMonkey(survey, customVariables, scheduleInterceptTitle, scheduleInterceptParams) {
    UIManager.dispatchViewManagerCommand(
      findNodeHandle(this),
      UIManager.getViewManagerConfig('RNSurveyMonkeyView').Commands
        .presentSurveyMonkey,
      [survey, customVariables, scheduleInterceptTitle, scheduleInterceptParams]
    );
  }

  render() {
    const { onRespondentDidEndSurvey, cancelButtonTintColor } = this.props;
    return (
      <RNMonkeyView
        onRespondentDidEndSurvey={ (event) => {
          if (onRespondentDidEndSurvey) {
            onRespondentDidEndSurvey(event.nativeEvent);
          }
        } }
        cancelButtonTintColor={ cancelButtonTintColor }
      />
    );
  }
}
