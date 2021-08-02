describe UserInterface::Color do
  let(:red) { 155 }
  let(:green) { 22 }
  let(:blue) { 16 }
  let(:alpha) { 255 }
  let(:described_instance) { described_class.new(red, green, blue, alpha) }

  describe ".white" do
    subject { described_class.white }

    it "is white" do
      expect(subject.red).to eq(255)
      expect(subject.green).to eq(255)
      expect(subject.blue).to eq(255)
      expect(subject.alpha).to eq(255)
    end
  end

  describe ".black" do
    subject { described_class.black }

    it "is black" do
      expect(subject.red).to eq(0)
      expect(subject.green).to eq(0)
      expect(subject.blue).to eq(0)
      expect(subject.alpha).to eq(255)
    end
  end

  describe ".red" do
    subject { described_class.red }

    it "is red" do
      expect(subject.red).to eq(255)
      expect(subject.green).to eq(0)
      expect(subject.blue).to eq(0)
      expect(subject.alpha).to eq(255)
    end
  end

  describe ".green" do
    subject { described_class.green }

    it "is green" do
      expect(subject.red).to eq(0)
      expect(subject.green).to eq(255)
      expect(subject.blue).to eq(0)
      expect(subject.alpha).to eq(255)
    end
  end

  describe ".blue" do
    subject { described_class.blue }

    it "is blue" do
      expect(subject.red).to eq(0)
      expect(subject.green).to eq(0)
      expect(subject.blue).to eq(255)
      expect(subject.alpha).to eq(255)
    end
  end

  describe ".clear" do
    subject { described_class.clear }

    it "is clear" do
      expect(subject.red).to eq(0)
      expect(subject.green).to eq(0)
      expect(subject.blue).to eq(0)
      expect(subject.alpha).to eq(0)
    end
  end

  describe "#red" do
    subject { described_instance.red }
    it { is_expected.to eq(red) }
  end

  describe "#green" do
    subject { described_instance.green }
    it { is_expected.to eq(green) }
  end

  describe "#blue" do
    subject { described_instance.blue }
    it { is_expected.to eq(blue) }
  end

  describe "#alpha" do
    subject { described_instance.alpha }
    it { is_expected.to eq(alpha) }
  end

  describe "#to_s" do
    subject { described_instance.to_s }
    it { is_expected.to be_a(String) }
  end

  describe "#inspect" do
    subject { described_instance.inspect }
    it { is_expected.to be_a(String) }
  end

  describe "#==" do
    context "itself" do
      subject { described_instance == described_instance }

      it { is_expected.to eq(true) }
    end

    context "with another instance of the same color" do
      let(:other_instance) { described_class.new(red, green, blue, alpha) }
      subject { described_instance == other_instance }

      it { is_expected.to eq(true) }
    end

    context "with another instance of a different red" do
      let(:other_instance) { described_class.new(2, green, blue, alpha) }
      subject { described_instance == other_instance }

      it { is_expected.to eq(false) }
    end

    context "with another instance of a different green" do
      let(:other_instance) { described_class.new(red, 2, blue, alpha) }
      subject { described_instance == other_instance }

      it { is_expected.to eq(false) }
    end

    context "with another instance of a different blue" do
      let(:other_instance) { described_class.new(red, green, 2, alpha) }
      subject { described_instance == other_instance }

      it { is_expected.to eq(false) }
    end

    context "with another instance of a different alpha" do
      let(:other_instance) { described_class.new(red, green, blue, 2) }
      subject { described_instance == other_instance }

      it { is_expected.to eq(false) }
    end
  end
end
