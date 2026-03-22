abstract class BaseModel<E> {
  const BaseModel();
  E toEntity();
  Map<String, dynamic> toJson();
}
