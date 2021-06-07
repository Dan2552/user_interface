describe UserInterface::RunLoop do
  let(:described_instance) { described_class.new }

  describe ".main" do
    subject { described_class.main }


  end

  describe "#add_timer" do
    let(:timer) { double(:timer) }
    let(:mode) { :default }
    subject { described_instance.add_timer(timer, mode: mode) }

    it { is_expected.to eq([timer]) }

    context "when the mode is invalid" do
      let(:mode) { :banana }

      it "raises" do
        expect { subject }
          .to raise_error("Unknown mode")
      end
    end
  end

  describe "#run" do
    subject { described_instance.run }

    before do
      allow(UserInterface)
        .to receive(:refresh_delta)
        .and_return(0)
    end

    it "runs a loop" do
      expect(described_instance)
        .to receive(:loop)

      subject
    end

    it "refreshes delta" do
      expect(UserInterface)
        .to receive(:refresh_delta)
        .and_return(2)

      expect(UserInterface::Time)
        .to receive(:delta=)
        .with(2)
        .and_raise(UserInterface::ExitError)

      begin
        subject
      rescue UserInterface::ExitError
      end
    end

    context "when there is a timer" do
      let(:timer) { double(:timer) }

      before do
        described_instance.add_timer(timer)
      end

      it "checks to see if the timer is invalidated" do
        expect(timer)
          .to receive(:invalidated?) do
            # raise to escape the loop, just for the spec
            raise UserInterface::ExitError
          end

        begin
          subject
        rescue UserInterface::ExitError
        end
      end

      context "when the timer is invalidated" do
        let(:timer) { double(:timer, invalidated?: true) }

        before do
          exit_timer = double(:exit_timer)

          expect(exit_timer)
            .to receive(:invalidated?) do
              # raise to escape the loop, just for the spec
              raise UserInterface::ExitError
            end

          described_instance.add_timer(exit_timer)
        end

        it "does not check to see if the timer interval has elapsed" do
          expect(timer)
            .to_not receive(:interval_elapsed?)

          begin
            subject
          rescue UserInterface::ExitError
          end
        end

        it "removes the timer from the timers" do
          # Note: this spec isn't really possible with the way ExitError is
          # raised in the context in order to escape the loop. So this spec just
          # sits here as documentation if nothing else.
          #
          # expect { subject rescue nil }
          #   .to change { described_instance.instance_variable_get(:"@timers")[:default].count }
          #   .from(2)
          #   .to(1)

          begin
            subject
          rescue UserInterface::ExitError
          end
        end
      end

      context "when the timer is not invalidated" do
        let(:timer) { double(:timer, invalidated?: false) }

        it "checks to see if the timer interval has elapsed" do
          expect(timer)
            .to receive(:interval_elapsed?) do
              # raise to escape the loop, just for the spec
              raise UserInterface::ExitError
            end

          begin
            subject
          rescue UserInterface::ExitError
          end
        end

        context "when the interval has elapsed" do
          let(:timer) { double(:timer, invalidated?: false, interval_elapsed?: true) }

          it "fires the timer" do
            expect(timer)
              .to receive(:fire) do
                # raise to escape the loop, just for the spec
                raise UserInterface::ExitError
              end

            begin
              subject
            rescue UserInterface::ExitError
            end
          end
        end

        context "when the interval has not elapsed" do
          let(:timer) { double(:timer, invalidated?: false, interval_elapsed?: false) }

          before do
            exit_timer = double(:exit_timer)

            expect(exit_timer)
              .to receive(:invalidated?) do
                # raise to escape the loop, just for the spec
                raise UserInterface::ExitError
              end

            described_instance.add_timer(exit_timer)
          end

          it "does not fire the timer" do
            expect(timer)
              .to_not receive(:fire)

            begin
              subject
            rescue UserInterface::ExitError
            end
          end
        end
      end
    end
  end
end
