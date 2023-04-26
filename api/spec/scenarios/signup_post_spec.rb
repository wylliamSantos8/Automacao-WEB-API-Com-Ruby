describe "POST /signup" do
  context "novo usuário" do
    before(:all) do
      payload = { name: "Pitty", email: "Pitty@bol.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      @result = Signup.new.create(payload)
    end
    it "valida status code" do
      expect(@result.code).to eql 200
    end

    it "valida id do usuário" do
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario duplicado" do
    before(:all) do
      # dado que eu tenho um novo usuario
      payload = { name: "Joao da Silva", email: "joao@ig.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      # e o email desse usuario ja foi cadastrado no sistema
      Signup.new.create(payload)

      #quando faço uma requisição para a rota signup
      @result = Signup.new.create(payload)
    end

    it "deve retornar 409" do
      #então deve retornar 409
      expect(@result.code).to eql 409
    end

    it "deve retornar mensagem" do
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  #name é orbigatório
  #email é orbigatório
  #password é orbigatório
  examples = [
    {
      title: "nome em branco",
      payload: { name: "", email: "maria@gmail.com", password: "abc123" },
      code: 412,
      error: "required name",
    },
    {
      title: "sem o campo nome",
      payload: { email: "maria@gmail.com", password: "pwd123" },
      code: 412,
      error: "required name",
    },
    {
      title: "email em branco",
      payload: { name: "Maria de Sousa", email: "", password: "pwd123" },
      code: 412,
      error: "required email",
    },
    {
      title: "email invalido",
      payload: { name: "Maria de Sousa", email: "maria&gmail.com", password: "pwd123" },
      code: 412,
      error: "wrong email",
    },
    {
      title: "sem o campo email",
      payload: { name: "Maria de Sousa", password: "pwd123" },
      code: 412,
      error: "required email",
    },
    {
      title: "senha em branco",
      payload: { name: "Maria de Sousa", email: "maria@gmail.com", password: "" },
      code: 412,
      error: "required password",
    },
    {
      title: "sem o campo senha",
      payload: { name: "Maria de Sousa", email: "maria@gmail.com" },
      code: 412,
      error: "required password",
    },
  ]
  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Signup.new.create(e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end

      it "valida mensagem de erro" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end
