require "test/unit"
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'fix_microsoft_links'

class RegexTest < Test::Unit::TestCase

  def test_outook
    assert_no_match "Microsoft Office/14.0 (Windows NT 6.0; Microsoft Outlook 14.0.4760; Pro)"
    assert_no_match "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; InfoPath.3; Microsoft Outlook 14.0.6131; ms-office; MSOffice 14)"
  end

  def test_other_microsoft_apps
    # Office 2011 on Mac
    assert_match "Mozilla/5.0 (Macintosh; Intel Mac OS X) Word/14.20.0"
    assert_match "Mozilla/5.0 (Macintosh; Intel Mac OS X) Excel/14.20.0"
    assert_match "Mozilla/5.0 (Macintosh; Intel Mac OS X) PowerPoint/14.20.0"
    # some others on windows 7
    assert_match "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; ms-office)"
  end

  def test_konqueror_kio
    # LibreOffice on KDE will check links just like MSOffice
    assert_match "Mozilla/5.0 (X11; Linux x86_64) KHTML/5.37.0 (like Gecko) Konqueror/5 KIO/5.37"
    assert_match "Mozilla/5.0 (X11; Linux x86_64) KHTML/5.36.0 (like Gecko) Konqueror/5 KIO/5.36"
    assert_match "Mozilla/5.0 (X11; Linux x86_64) KHTML/5.33.0 (like Gecko) Konqueror/5 KIO/5.33"
  end

  def test_others
    assert_no_match "aldsfjlkads asdljfjl Words"
    assert_no_match "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.21 (KHTML, like Gecko) konqueror/4.14.22 Safari/537.21"
    assert_no_match "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.46 Safari/536.5"
  end


  private

  def assert_match(user_agent)
    assert FixMicrosoftLinks::Rack::Response.new(nil).matching_user_agent?(user_agent), "Expected middleware to apply to user agent: #{user_agent}"
  end

  def assert_no_match(user_agent)
    assert !FixMicrosoftLinks::Rack::Response.new(nil).matching_user_agent?(user_agent), "Did not expect middleware to apply to user agent: #{user_agent}"
  end

end
