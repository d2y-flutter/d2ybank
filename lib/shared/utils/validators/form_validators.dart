typedef FieldValidator = String? Function(String? value);

abstract final class FormValidators {
  static FieldValidator compose(List<FieldValidator> validators) {
    return (value) {
      for (final v in validators) { final e = v(value); if (e != null) return e; }
      return null;
    };
  }
  static FieldValidator required([String fieldName = 'This field']) =>
      (value) => value == null || value.trim().isEmpty ? '$fieldName is required' : null;
  static FieldValidator minLength(int length) =>
      (value) => value != null && value.length < length ? 'Min $length characters' : null;
  static FieldValidator maxLength(int length) =>
      (value) => value != null && value.length > length ? 'Max $length characters' : null;
}
