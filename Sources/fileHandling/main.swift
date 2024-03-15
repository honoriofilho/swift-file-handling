// The Swift Programming Language
// https://docs.swift.org/swift-book

// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

let filePath = "/file-handling-swift/pokeDex.txt"
let seperators = CharacterSet(charactersIn: "|")


struct Status{
    var fome: Int = 100
    var saude: Int = 100
    var felicidade: Int = 100
}

struct Buddy {
    var nomeBuddy: String? = nil
    let tipo: String
    let especie: String
    var xp: Int = 10
    var level: Int = 1
    var status: Status = Status()

    func serialize() -> String {
        return "\(nomeBuddy ?? "\(especie)")|\(especie)|\(xp)|\(level)|\(status.fome)|\(status.saude)|\(status.felicidade)"
    }
}

var pikachu: Buddy = Buddy(tipo: "Elétrico", especie: "Pikachu")

var charmander: Buddy = Buddy(tipo: "Fogo", especie: "charmander", status: Status(fome: 10))

var squirtle: Buddy = Buddy(tipo: "Agua", especie: "squirtle")

var bulbasaur: Buddy = Buddy(tipo: "Planta", especie: "bulbasaur")

let pokemons:[Buddy] = [pikachu, charmander, squirtle, bulbasaur]

// Função auxiliar: Limpa o terminal
func clearTerminalScreen() {
    let clear = Process()
    clear.launchPath = "/usr/bin/clear"
    clear.arguments = []
    clear.launch()
    clear.waitUntilExit()
}

func obterBuddyValido() -> Int {
    while true {
        print("Por favor, digite o número correspondente ao pokemon que deseja escolher: ")
        if let input = readLine(strippingNewline: true), let numero = Int(input), (1...3).contains(numero) {
            return numero
        } else {
            print("Entrada inválida. Tente novamente.\n")
        }
    }
}

func criarArquivo(conteudo: String, filePath: String) {
    let fileManager = FileManager.default

    if let data = conteudo.data(using: .utf8) {
        let success = fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        if success {
            print("Arquivo criado e salvo com sucesso")
        } else {
            print("Erro ao criar arquivo")
        }
    } else {
        print("Erro ao converter String para Data")
    }
}

func lerArquivo(index: Int, filePath: String) -> String{
    let fileManager = FileManager.default

    if let fileData = fileManager.contents(atPath: filePath) {
        if let fileContentString = String(data: fileData, encoding: .utf8) {
            let arr = fileContentString.components(separatedBy: seperators)
            //Retorna a string com a primeira letra maiuscula
            return arr[index].capitalized
        }
    }
    return ""
}

func main(){

    //Captura a entrada do usuário
    let input = obterBuddyValido()

    print("Você escolheu o Pokemon: \(lerArquivo(index: 0, filePath: filePath))")

    //Organiza os campos da struct em uma única string
    let choosedBuddy = pokemons[input].serialize()

    //Gera o arquivo onde os dados serão salvos
    criarArquivo(conteudo: choosedBuddy, filePath: filePath)

    //Declara um array para armazenar os dados da struct
    let buddy = choosedBuddy.components(separatedBy: seperators)

    print("Array de campos da struct: \(buddy)")

    // A função recebe o index do array serializado e o caminho do arquivo,
    // retornando apenas o campo que foi escolhido com base no index informado no parâmetro
    print("Nome do Buddy: \(lerArquivo(index: 0, filePath: filePath))")

}

main()
