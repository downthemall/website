require "spec_helper"

describe AmoStats do
  subject { AmoStats.new("downthemall") }

  describe ".avg_daily_users" do
    it "returns the average number of users for the extension" do
      Timecop.freeze(Date.new(2013, 4, 13)) do
        VCR.use_cassette('amo_stats_avg_users') do
          expect(subject.avg_daily_users).to be 1879327
        end
      end
    end
  end

  describe ".avg_daily_downloads" do
    it "returns the average number of daily downloads for the extension" do
      Timecop.freeze(Date.new(2013, 4, 13)) do
        VCR.use_cassette('amo_stats_avg_downloads') do
          expect(subject.avg_daily_downloads).to be 16666
        end
      end
    end
  end

  describe ".total_downloads" do
    it "returns the total number of downloads for the extension" do
      Timecop.freeze(Date.new(2013, 4, 13)) do
        VCR.use_cassette('amo_stats_downloads_counter') do
          expect(subject.total_downloads).to be 57125017
        end
      end
    end
  end
end


