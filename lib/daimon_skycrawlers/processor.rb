require 'daimon_skycrawlers'
require 'daimon_skycrawlers/configure_songkick_queue'
require 'daimon_skycrawlers/url_consumer'
require 'daimon_skycrawlers/http_response_consumer'

module DaimonSkycrawlers
  class Processor
    class << self
      def run(process_name: 'daimon-skycrawler')
        SongkickQueue::Worker.new(process_name, [HTTPResponseConsumer]).run
      end

      def enqueue_http_response(url, header, body)
        SongkickQueue.publish('daimon-skycrawler.http-response', url: url, header: header, body: body)
      end
    end
  end
end
