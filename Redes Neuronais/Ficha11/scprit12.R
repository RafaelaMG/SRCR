library("neuralnet")

trainset<- read.csv(
    "C:\\Users\\Demo\\Desktop\\Aula12\\creditset.csv", header = TRUE,sep=",",dec="."
)

#definição da formula de treino
formulaRNA <- default10yr ~ age+LTI

#treinar rede neuronal chamada "creditnet" com 5 nodos intermédios
creditnet <- neuralnet(formulaRNA, trainset, hidden= c(5),threshold=0.1)
creditnet2 <- neuralnet(formulaRNA, trainset, hidden= c(6,4,2), lifesign="full", threshold=0.01)

#imprimir resultados
print(creditnet)
print(creditnet1$call)
#...
creditnet$model.list

#desenhar rede neuronal
plot(creditnet)
plot(creditnet$covariate[,1],creditnet$response, type="i")

#criar datagrame para os casos de teste
test <- data.frame(Vencimento=0.4, Habitacao=0.2, Automovel=0.40, Carta=0.1)
test [2,] <- data.frame(Vencimento=0.7, Habitacao=0.4, Automovel=0.55, Carta=0.1)

#testar novos casos da rede neuronal
creditnet.results <- compute(creditnet, test)

# imprimir o resultado final (uso da função round como auxiliar para arredondar o resultado final)
print(round(creditnet.results$net.result))
print(round(creditnet.results$net.result, digits=1))

#testar a RNA com os casos usados para treino
teste<-subnet(trainset, select=c("Vencimento","Habitacao","Automovel","Cartao"))
creditnet.results <- compute(creditnet, teste)
print(round(creditnet.results$net.result,digit=0))
