defmodule AppBancoDados.Employee do    

def process(list) do 
  employees = get_in(list, ["employees"])
  process_employees(employees)
end 

def process_employees([head | tail]) do    
    entries = Enum.sort_by(get_in(head, ["entries"]), &(DateTime.from_iso8601(&1)))

    minutes = process_days(0,entries)
    days = count_days(entries)
    workload = get_in(head,["workload"])    

    balance = turn_minutes(minutes) -(days * workload["workload_in_minutes"])    
    
    IO.puts "Nome: #{head["name"]}"
    IO.puts "PIS: #{head["pis_number"]}"
    IO.puts "Saldo de horas: #{balance} minutos"

    process_employees(tail)
  end

  def process_employees([]), do: 0

  def process_days(interval,[head | tail]) do        
    if (interval == 0 && tail != []) do
      {:ok, dt, 0} = DateTime.from_iso8601(head)
      {:ok, dt2, 0} = DateTime.from_iso8601(List.first(tail))
      diference = Date.diff(dt2, dt)

      if (diference == 0) do
        DateTime.diff(dt2, dt, :second) + process_days(1,tail)            
      else
        process_days(1,tail)
      end 
    else 
      process_days(0,tail)
    end        
  end

  def process_days(interval,[]), do: 0

  def count_days([head | tail]) do
    if (tail != []) do
      {:ok, dt, 0} = DateTime.from_iso8601(head)
      {:ok, dt2, 0} = DateTime.from_iso8601(List.first(tail))

      diference = Date.diff(dt2, dt)          
      if (diference > 0) do
        1 + count_days(tail)              
      else
        0 + count_days(tail)              
      end 
    else 
      0 + count_days(tail)
    end        
  end

  def count_days([]), do: 1
  
  def turn_minutes(seconds) do
    seconds / 60
  end 
end