require "test/unit"
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'fix_microsoft_links'

class RegexTest < Test::Unit::TestCase

  REGEX = FixMicrosoftLinks::Rack::Response::USER_AGENTS_REGEX


  def test_outook
    assert_no_match "Microsoft Office/14.0 (Windows NT 6.0; Microsoft Outlook 14.0.4760; Pro)"
  end

  def test_other_microsoft_apps
    # Office 2011 on Mac
    assert_match "Mozilla/5.0 (Macintosh; Intel Mac OS X) Word/14.20.0"
    assert_match "Mozilla/5.0 (Macintosh; Intel Mac OS X) Excel/14.20.0"
    assert_match "Mozilla/5.0 (Macintosh; Intel Mac OS X) PowerPoint/14.20.0"
  end

  def test_others
    assert_no_match "aldsfjlkads asdljfjl Words"
    assert_no_match "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46 Safari/536.5"
  end


  private

  def assert_match(user_agent)
    assert user_agent =~ REGEX, "Expected middleware to apply to user agent: #{user_agent}"
  end

  def assert_no_match(user_agent)
    assert !(user_agent =~ REGEX), "Did not expect middleware to apply to user agent: #{user_agent}"
  end


end