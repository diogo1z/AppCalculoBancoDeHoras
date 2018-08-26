defmodule AppBancoDados.CLI do
  def main(args) do
    parse_args(args)
    |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean],
                              aliases: [h: :help])
      case parse do
          {[help: true], _, _}
            -> :help
          {_, [file], _}
            -> {file}

      end
  end

  def process({file}) do  
    if file == "E" do
      AppBancoDados.JsonReader.get_json("lib/app_banco_dados/priv/input.json")       
      |> AppBancoDados.JsonReader.extract_body 
      |> AppBancoDados.Employee.process
    else 
      AppBancoDados.JsonReader.get_json(file) 
      |> AppBancoDados.JsonReader.extract_body 
      |> AppBancoDados.Employee.process        
    end
  end

  def process(:help) do
    IO.puts """

    App de banco de dados
    ___________________________________
    Uso: app_banco_dados E --Para pegar o arquivo existent
    Uso: app_banco_dados <caminho do arquivo> --Para informar o diretório do arquivo
    Exemplo: app_banco_dados parse
    """
  end
end
