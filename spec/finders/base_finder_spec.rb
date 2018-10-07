describe BaseFinder do
  let(:base_finder) { described_class.new('search request') }

  describe '#driver' do
    context 'when headless? false' do
      before do
        allow(base_finder).to receive(:headless?).and_return(false)
      end

      it 'returns driver as :selenium_chrome' do
        expect(base_finder.driver).to eq :selenium_chrome
      end
    end

    context 'when headless? true' do
      before do
        allow(base_finder).to receive(:headless?).and_return(true)
      end

      it 'returns driver as :selenium_chrome_headless' do
        expect(base_finder.driver).to eq :selenium_chrome_headless
      end
    end
  end
end
