# Diario de Estudo em Ruby
require './study_item.rb'
require './save_load.rb'

# Procedimento Menu
def menu_inicial
    escolha = ""
    while escolha != 0 do
        clear_screen
        puts "Diario de estudos"
        puts "[1] Cadastrar uma tarefa para estudar \n[2] Alterar status da tarefa \n[3] Ver tarefas cadastradas \n[4] Buscar uma tarefa de estudo \n[5] Deletar tarefas \n[6] Salvar dados das tarefas \n[0] Sair \nEscolha uma opção:"
        escolha = gets.to_i 
        case escolha
        when 1
            cadastrar_tarefas
        when 2
            alterar_tarefas
        when 3
            ver_tarefas
        when 4
            buscar_tarefas
        when 5
            deletar_tarefas
        when 6
            salvar_dados
        when 0
            puts "Obrigado por usar Diario de estudos."
            puts "Saindo do programa ..."
        else
            puts "Desculpe, não entendi sua requisição."
        end
    end
end

# Procedimento Cadastrar item para estudar
def cadastrar_tarefas
    puts "Digite o Título do seu item de estudo: "
    titulo = gets.chomp()
    categoria = ""
    while categoria == "" do
        puts "Escolha qual a categoria desejada: \n[1]Ruby \n[2]Rails \n[3]HTML"
        categoria_escolha = gets.to_i
        case categoria_escolha
        when 1
            categoria = "Ruby"
        when 2 
            categoria = "Rails"
        when 3
            categoria = "HTML"
        else
            puts "Erro! Favor digite uma categoria valida." 
        end
    end
    $itens_estudo << StudyItem.new(titulo: titulo, categoria: categoria)
    puts "Estudo cadastrado com sucesso. Pressione qualquer tecla para continuar."
    gets
end

# Procedimento Alterar tarefas
def alterar_tarefas 
    if $itens_estudo == []
        puts "Desculpe, não encontramos itens cadastrados."
        puts "Pressione qualquer tecla para continuar."
    else
        puts "Escolha uma opção abaixo para alterar: "
        $itens_estudo.each_with_index{|item,index|item.mostrar_itens(index) if item.status == "A fazer"}
        item_desejado = gets.to_i
        $itens_estudo.each_with_index{|item,index|item.alterar_status if index == item_desejado}
        puts "Tarefa #{item_desejado} alterado status para Concluido"
    end
    gets
end

# Procedimento Ver tarefas
def ver_tarefas
    if $itens_estudo == []
        puts "Desculpe, não encontramos itens cadastrados."
        puts "Pressione qualquer tecla para continuar."
    else
        item_desejado = 0
        while (item_desejado != 1) || (item_desejado != 2) || (item_desejado != 3) do
            puts "Escolha uma opção abaixo: \n[1]Ver itens a fazer \n[2]Ver itens concluidos \n [3]Ver todos os itens"
            item_desejado = gets.to_i
            case item_desejado
            when 1
                $itens_estudo.each_with_index{|item,index|item.mostrar_itens(index) if item.status == "A fazer"}
                puts "Pressione qualquer tecla para continuar."
            when 2
                $itens_estudo.each_with_index{|item,index|item.mostrar_itens(index) if item.status == "Concluido"}
                puts "Pressione qualquer tecla para continuar."
            when 3
                $itens_estudo.each_with_index{|item,index|item.mostrar_itens(index)}
                puts "Pressione qualquer tecla para continuar."
            else
                puts "Erro! Favor digite um tipo valido." 
            end
        end
    end
    gets
end

# Procedimento Buscar tarefas de estudo
def buscar_tarefas
    puts "Digite uma palavra para procurar:"
    busca = gets.chomp().downcase  
    puts "Os resultados encontrados foram:"
    $itens_estudo.each_with_index{|item,index|item.buscar_itens(busca,index)}
    puts "Pressione qualquer tecla para continuar."
    gets
end

def deletar_tarefas
    puts "Digite o item que deseja deletar:"
    $itens_estudo.each_with_index{|item,index|item.mostrar_itens(index)}
    gets
    puts "Tarefa deletada com sucesso."
    puts "Pressione qualquer tecla para continuar."
end

# Procedimento Limpar a tela
def clear_screen
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
       system('cls')
     else
       system('clear')
    end
end

# Executa o procedimento menu inicial
carregar_dados
menu_inicial