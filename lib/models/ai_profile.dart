class AiProfile {
  String name;
  String avatarUrl;
  String personality;

  AiProfile({
    required this.name,
    required this.avatarUrl,
    required this.personality,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'avatarUrl': avatarUrl,
    'personality': personality,
  };

  factory AiProfile.fromJson(Map<String, dynamic> json) => AiProfile(
    name: json['name'],
    avatarUrl: json['avatarUrl'],
    personality: json['personality'],
  );
}
