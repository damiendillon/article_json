module ArticleJSON
  module Import
    module GoogleDoc
      module HTML
        class EmbeddedYoutubeVideoElement < EmbeddedElement
          # The type of this embedded element
          # @return [Symbol]
          def embed_type
            :youtube_video
          end

          class << self
            # Regular expression to check if a given string is a Youtube URL
            # Also used to extract the ID from the URL.
            # @return [Regexp]
            def url_regexp
              %r(
                ^\S*(?:youtube\.com\/
                  (?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)
                ([^"&?\/ ]{11})
              )xi
            end
          end
        end
      end
    end
  end
end
