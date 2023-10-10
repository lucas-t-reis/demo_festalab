
class CpfValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless valid_cpf?(value)
        record.errors.add(attribute, options[:message] || "is not a valid CPF")
      end
    end
  
    private

    CPF_EDGE_CASES = /^(\d)\1{10}$/
  
    # Source https://pt.wikipedia.org/wiki/Cadastro_de_Pessoas_F%C3%ADsicas#D%C3%ADgitos_verificadores
    def valid_cpf?(cpf)
      cpf = cpf.to_s.scan(/\d/).join
      return false if cpf.length != 11 || cpf =~ CPF_EDGE_CASES

      digits = cpf.chars.map(&:to_i)
      reversed_digits = digits[0..8].reverse
      v1, v2 = 0, 0

      reversed_digits.each_with_index do |digit, i|
        v1 += digit * (9 - (i % 10))
        v2 += digit * (9 - ((i + 1) % 10))
      end
      
      v1 = (v1 % 11) % 10
      v2 = v2 + v1 * 9
      v2 = (v2 % 11) % 10
      digits[9] == v1 && digits[10] == v2
    end
end