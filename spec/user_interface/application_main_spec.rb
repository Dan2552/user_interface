class AppDelegate
end

describe UserInterface::ApplicationMain do
  let(:described_instance) { described_class.new }

  describe "#launch" do
    subject { described_instance.launch }

    let(:delegate) do
      delegate = double(:delegate, respond_to?: true)
      allow(AppDelegate)
        .to receive(:new)
        .and_return(delegate)

      allow(delegate)
        .to receive(:application_will_finish_launching)
      allow(delegate)
        .to receive(:application_did_finish_launching)
      allow(delegate)
        .to receive(:application_did_become_active)
      allow(delegate)
        .to receive(:application_will_terminate)

      delegate
    end

    let(:run_loop) do
      run_loop = double(:run_loop, add_timer: nil, run: nil)
      allow(UserInterface::RunLoop)
        .to receive(:main)
        .and_return(run_loop)
      run_loop
    end

    let(:event_loop) do
      event_loop = double(:event_loop)
      allow(UserInterface::Timer)
        .to receive(:new)
        .and_return(event_loop)
      event_loop
    end

    before do
      delegate
      run_loop
      event_loop
    end

    it "informs delegate of lifecycle events" do
      expect(delegate).to receive(:application_will_finish_launching)
      expect(delegate).to receive(:application_did_finish_launching)
      expect(delegate).to receive(:application_did_become_active)
      expect(delegate).to receive(:application_will_terminate)
      subject
    end

    it "creates an event loop that repeats" do
      expect(UserInterface::Timer)
        .to receive(:new)
        .with(
          repeats: true,
          object: instance_of(UserInterface::EventLoop),
          selector: :update
        )

      subject
    end

    it "adds the event loop timer to the run loop" do
      expect(run_loop)
        .to receive(:add_timer)
        .with(event_loop)

      subject
    end

    it "executes the run loop" do
      expect(run_loop)
        .to receive(:run)

      subject
    end

    context "when the run loop raises ExitError" do
      before do
        expect(run_loop)
          .to receive(:run)
          .and_raise(UserInterface::ExitError)
      end

      it "doesn't raise" do
        expect { subject }
          .to_not raise_error
      end

      it "still informs delegate application_will_terminate" do
        expect(delegate).to receive(:application_will_terminate)
        subject
      end
    end
  end
end
