class User
{
  String? name,contact,key;
  User (this.name,this.contact,this.key);
  static User fromjson(Map m, String key)
  {
    return User(key,m['name'], m['contact']);
  }
}