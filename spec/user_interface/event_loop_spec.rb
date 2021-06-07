describe UserInterface::EventLoop do
  let(:described_instance) { described_class.new }

  describe "#update" do
    subject { described_instance.update }

    it "polls for events" do
      expect(UserInterface::Event)
        .to receive(:poll)

      subject
    end

    context "when poll yields a quit event" do
      before do
        event = double(:event, type: :quit)

        allow(UserInterface::Event)
          .to receive(:poll)
          .and_yield(event)
      end

      it "raises ExitError" do
        expect { subject }
          .to raise_error(UserInterface::ExitError)
      end
    end
  end
end
