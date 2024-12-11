class UploadImageDtoEntity {
  const UploadImageDtoEntity({
    required this.imageUrl,
  });

  final String imageUrl;

  UploadImageDtoEntity copyWith({
    String? imageUrl,
  }) {
    return UploadImageDtoEntity(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UploadImageDtoEntity && other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => imageUrl.hashCode;
}
