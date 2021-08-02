describe UserInterface::Label do
  let(:frame) { double(:frame, position: double(:position), size: double(:size)) }
  let(:described_instance) { described_class.new(frame) }

  describe "#text" do
    subject { described_instance.text }
    it { is_expected.to eq(nil) }

    it "can be set" do
      text = double(:text)
      described_instance.text = text
      expect(subject).to eq(text)
    end

    it "calls set_needs_display when set" do
      expect(described_instance)
        .to receive(:set_needs_display)

      text = double(:text)
      described_instance.text = text
    end
  end

  describe "#font" do
    subject { described_instance.font }
    it { is_expected.to be_a(CoreGraphics::Font) }

    it "can be set" do
      font = double(:font)
      described_instance.font = font
      expect(subject).to eq(font)
    end

    it "calls set_needs_display when set" do
      expect(described_instance)
        .to receive(:set_needs_display)

      font = double(:font)
      described_instance.font = font
    end
  end

  describe "#text_color" do
    subject { described_instance.text_color }
    it { is_expected.to eq(UserInterface::Color.black) }

    it "can be set" do
      text_color = double(:text_color)
      described_instance.text_color = text_color
      expect(subject).to eq(text_color)
    end

    it "calls set_needs_display when set" do
      expect(described_instance)
        .to receive(:set_needs_display)

      text_color = double(:text_color)
      described_instance.text_color = text_color
    end
  end

  describe "#text_alignment" do
    subject { described_instance.text_alignment }
    it { is_expected.to eq(:left) }

    it "can be set" do
      text_alignment = double(:text_alignment)
      described_instance.text_alignment = text_alignment
      expect(subject).to eq(text_alignment)
    end

    it "calls set_needs_display when set" do
      expect(described_instance)
        .to receive(:set_needs_display)

      text_alignment = double(:text_alignment)
      described_instance.text_alignment = text_alignment
    end
  end

  describe "#number_of_lines" do
    subject { described_instance.number_of_lines }
    it { is_expected.to eq(1) }

    it "can be set" do
      number_of_lines = double(:number_of_lines)
      described_instance.number_of_lines = number_of_lines
      expect(subject).to eq(number_of_lines)
    end

    it "calls set_needs_display when set" do
      expect(described_instance)
        .to receive(:set_needs_display)

      number_of_lines = double(:number_of_lines)
      described_instance.number_of_lines = number_of_lines
    end
  end

  xdescribe "#draw" do
    it "something"
  end
end
