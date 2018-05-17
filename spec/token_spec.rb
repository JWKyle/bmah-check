RSpec.describe Token do
  describe "#refresh" do
    it "Pulls the Current Wow Token Price from Battle.Net API" do
      expect(Token.refresh).to be_kind_of(Integer)
    end
  end
  describe "#current_price" do
    it "Shows the formated price as a  string" do
      expect(Token.current_price).to be_kind_of(String)
    end

    it "Shows the formated price ending with 'g'" do
      expect(Token.current_price).to end_with('g')
    end
  end
end
