describe ArticleJSON::Utils::OEmbedResolver::VimeoVideo do
  subject(:resolver) { described_class.new(element) }

  let(:element) do
    ArticleJSON::Elements::Embed.new(
      embed_type: :vimeo_video,
      embed_id: 42315417,
      caption: []
    )
  end
  let(:expected_oembed_url) do
    'https://vimeo.com/api/oembed.json?url=https://vimeo.com/42315417'
  end

  describe '#oembed_url' do
    subject { resolver.oembed_url }
    it { should eq expected_oembed_url }
  end

  describe '#oembed_data' do
    subject { resolver.oembed_data }

    let(:oembed_response) { File.read('spec/fixtures/vimeo_video_oembed.json') }
    let(:expected_headers) { { 'Content-Type' => 'application/json' } }
    let(:expected_response) { JSON.parse(oembed_response, symbolize_names: 1) }

    before do
      stub_request(:get, expected_oembed_url)
        .with(headers: expected_headers)
        .to_return(body: oembed_response)
    end

    context 'with no additional headers' do
      it { should eq expected_response }
    end

    context 'with additional headers' do
      before { ArticleJSON.configure { |c| c.oembed_user_agent = 'foobar' } }
      let(:expected_headers) { super().merge('User-Agent' => 'foobar') }
      it { should eq expected_response }
    end
  end
end
