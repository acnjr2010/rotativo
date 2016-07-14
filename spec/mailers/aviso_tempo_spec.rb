require "rails_helper"

RSpec.describe AvisoTempo, type: :mailer do
  describe "tempo_acabando" do
    let(:mail) { AvisoTempo.tempo_acabando }

    it "renders the headers" do
      expect(mail.subject).to eq("Tempo acabando")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
