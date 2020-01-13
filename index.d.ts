// Type definitions for react-native-survey-monkey
// Project: https://github.com/yarikpwnzer/react-native-survey-monkey
// Definitions by: Alan Soares <github.com/alanrsoares>

export interface ResponseAnswer {
  row_id: number;
  row_index: number;
  row_value: string;
}

export interface ResponseItem {
  page_index: number;
  question_value: string;
  question_index: number;
  question_id: number;
  page_id: number;
  answers: ResponseAnswer[];
}

export interface SurveyMonkeyError {
  code: string;
  description: string;
  fullDescription: string;
}
export interface Respondent {
  completion_status: string;
  responses: ResponseItem[];
}

export interface SurveyMonkeyResponse {
  respondent: null | Respondent;
  error: null | SurveyMonkeyError;
  target: number;
}

export interface SurveyMonkeyProps {
  /**
   * Callback invoked once the survey is ended, whether completed or not
   */
  onRespondentDidEndSurvey?: (response: SurveyMonkeyResponse) => void;
  /**
   * Only available on iOS, android doesn't use a title bar for webviews
   */
  cancelButtonTintColor?: string;
}

export interface ConfirmDialogConfig {
  title: string;
  body: string;
  positiveActionTitle: string;
  cancelTitle: string;
  afterInstallInterval: number;
  afterAcceptInterval: number;
  afterDeclineInterval: number;
}

declare class SurveyMonkey extends React.PureComponent<SurveyMonkeyProps> {
  /**
   * Shows the survey associated with the collectorHash
   *
   * @param collectorHash - hash generated for the SurveyMonkey mobile SDK
   * @param customVariables
   * @param customTitle
   * @param confirmDialogParams
   */
  public showSurveyMonkey(
    collectorHash: string,
    customVariables?: null | Record<string, string>,
    customTitle?: null | string,
    confirmDialogParams?: Partial<ConfirmDialogConfig>
  ): void;
}

export default SurveyMonkey;
