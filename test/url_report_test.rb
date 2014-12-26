require './test/test_helper'

class VirustotalAPIURLReportTest < Minitest::Test
  def setup
    @url     = 'http://www.google.com'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::URLReport
  end

  def test_report_response
    VCR.use_cassette('url_report') do
      vturl_report = VirustotalAPI::URLReport.find(@url, @api_key)

      # Make sure that the JSON was parsed
      assert vturl_report.kind_of?(VirustotalAPI::URLReport)
      assert vturl_report.report.kind_of?(Hash)
    end
  end

  def test_report_url
    VCR.use_cassette('url_report') do
      vturl_report = VirustotalAPI::URLReport.find(@url, @api_key)

      assert vturl_report.report_url.kind_of?(String)
    end
  end

  def test_scan_url
    VCR.use_cassette('url_report') do
      vturl_report = VirustotalAPI::URLReport.find(@url, @api_key)

      assert vturl_report.scan_id.kind_of?(String)
    end
  end

  def test_params
    VCR.use_cassette('url_report') do
      vturl_report = VirustotalAPI::URLReport.find(@url, @api_key)

      assert vturl_report.api_uri.kind_of?(String)
      assert vturl_report.api_uri, 'https://www.virustotal.com/vtapi/v2/url/report'
    end
  end

  def test_exists?
    VCR.use_cassette('url_report') do
      vturl_report = VirustotalAPI::URLReport.find(@url, @api_key)

      assert vturl_report.exists?, true
    end
  end
end