# DRY Don't Repeat yoursef => Não se repita

describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "betao@hotmail.com", password: "pwd123" }

      @result = Sessions.new.login(payload)
    end

    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  # examples = [
  #   {
  #     title: "Senha incorreta",
  #     payload: { email: "wylliamsantos@gmail.com", password: "pwd000" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "Usuario não existe",
  #     payload: { email: "404@gmail.com", password: "pwd000" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "Email em branco",
  #     payload: { email: "", password: "pwd000" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "Sem o campo e-mail",
  #     payload: { password: "pwd000" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "Senha em branco",
  #     payload: { email: "wylliamsantos@gmail.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "Senha o campo senha",
  #     payload: { email: "wylliamsantos@gmail.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  examples = Helpers::get_fixture("Login")

  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida id do usuário" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
