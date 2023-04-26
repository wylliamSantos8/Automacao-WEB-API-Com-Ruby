Before do
  @alert = Alert.new
  @login_page = LoginPage.new
  @signup_page = SignupPage.new
  @dash_page = DashPage.new
  @equipos_page = EquiposPage.new

  #page.driver.browser.manage.window.maximize #maximiza a janela do navegador conforme o monitor utilizado
  page.current_window.resize_to(1440, 900) #define um tamanho X para o navegadar maximizar a tela
end

After do
  temp_shot = page.save_screenshot("logs/temp_screenshot.png")

  Allure.add_attachment(
    name: "Screenshot",
    type: Allure::ContentType::PNG,
    source: File.open(temp_shot),
  )
end
