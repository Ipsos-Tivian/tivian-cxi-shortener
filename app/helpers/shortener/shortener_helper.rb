module Shortener::ShortenerHelper
  DEFAULT_HTTP_PORT = 80.freeze

  # generate a url from a url string
  def short_url(url, req: request, owner: nil, custom_key: nil,
                expires_at: nil, fresh: false, meta: nil, url_options: {},
                related_id: nil, source_type: nil)
    short_url = Shortener::ShortenedUrl.generate(url,
                                                 owner:      owner,
                                                 custom_key: custom_key,
                                                 expires_at: expires_at,
                                                 fresh:      fresh,
                                                 meta:       meta,
                                                 related_id: related_id,
                                                 source_type:     source_type)

    if short_url
      options = {
        controller: 'shortener/shortened_urls',
        action:     :show,
        id:         short_url.unique_key,
        only_path:  false,
        host:       req.host,
        protocol:   req.protocol
      }
      options.merge!({ port: req.port }) unless req.port == DEFAULT_HTTP_PORT

      Rails.application.routes.url_for(options.merge(url_options))
    else
      url
    end
  end

end
