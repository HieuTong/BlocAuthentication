abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFromStatus extends FormSubmissionStatus {
  const InitialFromStatus();
}

class FormSubmmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final Object exception;

  SubmissionFailed(this.exception);
}
