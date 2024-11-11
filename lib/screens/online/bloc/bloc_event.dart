abstract class OnlineEventClass{}

class GetOnlineData extends OnlineEventClass{}
class PostOnlineData extends OnlineEventClass{
  Map<String,dynamic> mBody;
  PostOnlineData({required this.mBody});
}