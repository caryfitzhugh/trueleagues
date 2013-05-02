$:.unshift File.expand_path(File.dirname(__FILE__) + "/..")
require 'test_helper'

class IncomingMailControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "we can push in a message" do
    request.env['RAW_POST_DATA'] = test_message
    post :ingest
    assert_response :success

    messages = REDIS.lrange(IncomingMailController::REDIS_KEY, 0, -1)
    assert_equal 1, messages.length


    sign_in(Account.make!)
    get :index
    assert_response :success
  end
private
  def test_message
    hash = {
      "From" => "myUser@theirDomain.com",
      "FromFull" => {
        "Email" => "myUser@theirDomain.com",
        "Name" => "John Doe"
      },
      "To" => "451d9b70cf9364d23ff6f9d51d870251569e+ahoy@inbound.postmarkapp.com",
      "ToFull" => [
        {
          "Email" => "451d9b70cf9364d23ff6f9d51d870251569e+ahoy@inbound.postmarkapp.com",
          "Name" => ""
        }
      ],
      "Cc"=>  "\"Full name\" <sample.cc@emailDomain.com>, \"Another Cc\" <another.cc@emailDomain.com>",
      "CcFull"=>  [
        {
          "Email"=>  "sample.cc@emailDomain.com",
          "Name"=>  "Full name"
        },
        {
          "Email"=>  "another.cc@emailDomain.com",
          "Name"=>  "Another Cc"
        }
      ],
      "ReplyTo"=>  "myUsersReplyAddress@theirDomain.com",
      "Subject"=>  "This is an inbound message",
      "MessageID"=>  "22c74902-a0c1-4511-804f2-341342852c90",
      "Date"=>  "Thu, 5 Apr 2012 16=> 59=> 01 +0200",
      "MailboxHash"=>  "ahoy",
      "TextBody"=>  "[ASCII]",
      "HtmlBody"=>  "[HTML(encoded)]",
      "Tag"=>  ""
    }
    hash.to_json
  end
end
