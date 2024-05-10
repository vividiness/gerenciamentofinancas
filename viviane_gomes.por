programa
{
	
	inclua biblioteca Texto --> txt
	inclua biblioteca Tipos --> tp

	//Variáveis
	real saldo = 0.0
	real saldo_atual = 0.0

	real despesa_total = 0.0

	//metas
	real meta_alimentacao = 0.0
	real meta_transporte = 0.0
	real meta_moradia = 0.0
	real meta_lazer = 0.0

	logico definiuMeta = falso

	//despesa[0] = alimentação | despesa[1] = transporte | despesa[2] = moradia | despesa[3] = lazer
	real dados_despesas[4] = {0.0, 0.0, 0.0, 0.0}   
	cadeia data_despesas[4] = {"", "", "", ""}

	//##############################################################################################################
	
	// Funções 
	funcao cadeia itensMenu(){
		retorne "\n\n------------------- Menu -------------------" +
				"\nDigite o número para ir a opção"+
				"\n1 - Registros {despesas e registros}"+
				"\n2 - Visualizar resumo financeiro"+
				"\n3 - Definir meta de orçaamento"+
				"\n4 - Analisar tendências financeira"+
				"\n-------------------------------------------"
	}

	funcao registrarDespesa(){
		
		real v
		cadeia c, d
		
		escreva("\nDigite o valor da despesa: \n=>")
		leia(v)
		
		escreva("\nDigite a categoria \nAlimentacao, Transporte, Moradia, Lazer \n=>")
		leia(c)
		c = txt.caixa_alta(c)
		
		escreva("\nDigite a data da despesa \n=>")
		leia(d)
		
		se (v > 0 e c != "" e c!= " " e d != "" e d != " "){
			
			//pos[0] = alimentação
			se (c == "ALIMENTACAO"){
				//verificação de meta
				se (definiuMeta){
					cadeia resp
					se (verificarMetaAlimentacao() == "Atingiu a meta." ou verificarMetaAlimentacao() == "Ultrapassou a meta."){
						escreva("\nMeta de gasto na categoria [ALIMENTAÇÃO] atingida. \nDeseja continuar mesmo assim? 's' para Sim e 'n' para Não.")
						leia(resp)

						resp = txt.caixa_alta(resp)

						se (resp == "S"){
							dados_despesas[0] += v
							data_despesas[0] += d+", "
							
						}senao se (resp == "N"){
							//parar o código.
						}senao{
							escreva("\nOpção inválida!")
						}
					}
				}senao{
				dados_despesas[0] += v
				data_despesas[0] += d+", "
			}
			}
			//pos[1] = transporte
			senao se (c == "TRANSPORTE"){
				se (definiuMeta){
					cadeia resp
					se (verificarMetaTransporte() == "Atingiu a meta." ou verificarMetaTransporte() == "Ultrapassou a meta."){
						escreva("\nMeta de gasto na categoria [TRANSPORTE] atingida. \nDeseja continuar mesmo assim? 's' para Sim e 'n' para Não.")
						leia(resp)

						resp = txt.caixa_alta(resp)

						se (resp == "S"){
							dados_despesas[1] += v
							data_despesas[1] += d+", "
							
						}senao se (resp == "N"){
							//parar o código.
						}senao{
							escreva("\nOpção inválida!")
						}
					}
					
				}senao{
					dados_despesas[1] += v
					data_despesas[1] += d+", " 	
			}
		}
			
			//pos[2] = moradia
			senao se (c == "MORADIA"){
				se (definiuMeta){
					cadeia resp
					se (verificarMetaMoradia() == "Atingiu a meta." ou verificarMetaMoradia() == "Ultrapassou a meta."){
						escreva("\nMeta de gasto na categoria [MORADIA] atingida. \nDeseja continuar mesmo assim? 's' para Sim e 'n' para Não.")
						leia(resp)

						resp = txt.caixa_alta(resp)

						se (resp == "S"){
							dados_despesas[2] += v
							data_despesas[2] += d+", "
							
						}senao se (resp == "N"){
							//parar o código.
						}senao{
							escreva("\nOpção inválida!")
						}
					}
					
				}senao{
					dados_despesas[2] += v
					data_despesas[2] += d+", " 	
			}
		}
				
			//pos[3] = lazer
			senao se (c == "LAZER"){
				se (definiuMeta){
					cadeia resp
					se (verificarMetaLazer() == "Atingiu a meta." ou verificarMetaLazer() == "Ultrapassou a meta."){
						escreva("\nMeta de gasto na categoria [LAZER] atingida. \nDeseja continuar mesmo assim? 's' para Sim e 'n' para Não.")
						leia(resp)

						resp = txt.caixa_alta(resp)

						se (resp == "S"){
							dados_despesas[3] += v
							data_despesas[3] += d+", "
							
						}senao se (resp == "N"){
							//parar o código.
						}senao{
							escreva("\nOpção inválida!")
						}
					}
					
				}senao{
					dados_despesas[3] += v
					data_despesas[3] += d+", " 	
			}
			
		  }
			
			}
			senao{
				escreva("\função registrarDespesa(): O usuário digitou uma categoria de despesa inválida!")
			}
	
}

	funcao registrarReceita(){
		real v
		
		escreva("Valor do depósito \n=>")
		leia(v)

		enquanto(v <= 0){
			escreva("Digite um valor válido para depositar! \n=>")
			leia(v)	
		}
		saldo+=v
	}
	
	//Cálculo de despesas
	funcao calcularDespesaTotal(real despesas[]){
		para(inteiro i=0; i<4; i++){
			despesa_total+=despesas[i]}	
			saldo -= despesa_total	
	}

	//Verificando a Meta da [ALIMENTACAO]
	funcao cadeia verificarMetaAlimentacao(){		
		real menor_valor = dados_despesas[0]-meta_alimentacao

		//se o valor negativo, é porque ultrapassou a meta.
		se(menor_valor <0){
			retorne "Ultrapassou a meta." 
		}senao se (menor_valor == 0){
			retorne "Atingiu a meta."
		}senao se (menor_valor >= 5){
			retorne "Faltam R$"+tp.real_para_cadeia(menor_valor)+ "para ultrapassar o valor da meta."
		}senao{
			retorne "funcao verificarMetaAlimentacao(): erro no cálculo do valor da meta."
		}
	}

	//Verificando a Meta da [TRANSPORTE]
	funcao cadeia verificarMetaTransporte(){		
		real menor_valor = dados_despesas[1]-meta_transporte

		//se o valor negativo, é porque ultrapassou a meta.
		se(menor_valor <0){
			retorne "Ultrapassou a meta."
		}senao se (menor_valor == 0){
			retorne "Atingiu a meta."
		}senao se (menor_valor >= 5){
			retorne "Faltam R$"+tp.real_para_cadeia(menor_valor)+ "para ultrapassar o valor da meta."
		}senao{
			retorne "funcao verificarMetaTransporte(): erro "
		}
	}

	//Verificando a Meta da [MORADIA]
	funcao cadeia verificarMetaMoradia(){		
		real menor_valor = dados_despesas[2]-meta_moradia

		//se o valor negativo, é porque ultrapassou a meta.
		se(menor_valor <0){
			retorne "Ultrapassou a meta."
		}senao se (menor_valor == 0){
			retorne "Atingiu a meta."
		}senao se (menor_valor >= 5){
			retorne "Faltam R$"+tp.real_para_cadeia(menor_valor)+ "para ultrapassar o valor da meta."
		}senao{
			retorne "funcao verificarMetaMoradia(): erro "
		}
	}

	//Verificando a Meta do [LAZER]
	funcao cadeia verificarMetaLazer(){		
		real menor_valor = dados_despesas[3]-meta_lazer

		//se o valor negativo, é porque ultrapassou a meta.
		se(menor_valor <0){
			retorne "Ultrapassou a meta."
		}senao se (menor_valor == 0){
			retorne "Atingiu a meta."
		}senao se (menor_valor >= 5){
			retorne "Faltam R$"+tp.real_para_cadeia(menor_valor)+ "para ultrapassar o valor da meta."
		}senao{
			retorne "funcao verificarMetaLazer(): erro "
		}
	}

	//funções para definir metas
	funcao definirMeta_Categoria(inteiro categoria){	
		real valor	
		//alimentação
		se (categoria == 1){
			escreva("\nDigite o valor da meta que deseja para a categoria [ALIMENTAÇÃO]: ")
			leia(valor)

			se(valor >=0){
				meta_alimentacao = valor
				definiuMeta = verdadeiro
			}senao{
				escreva("\nDigite um valor válido!")
			}
		}

		//Transporte
		senao se (categoria == 2){
			escreva("\nDigite o valor da meta que deseja para a categoria [TRANSPORTE]: ")
			leia(valor)

			se(valor >=0){
				meta_transporte = valor
				definiuMeta = verdadeiro
			}senao{
				escreva("\nDigite um valor válido!")
			}
		}

		//Moradia
		senao se (categoria == 3){
			escreva("\nDigite o valor da meta que deseja para a categoria [MORADIA]: ")
			leia(valor)

			se(valor >=0){
				meta_moradia = valor
				definiuMeta = verdadeiro
			}senao{
				escreva("\nDigite um valor válido!")
			}
		}

		//Lazer
		senao se (categoria == 4){
			escreva("\nDigite o valor da meta que deseja para a categoria [LAZER]: ")
			leia(valor)

			se(valor >=0){
				meta_lazer = valor
				definiuMeta = verdadeiro
			}senao{
				escreva("\nDigite um valor válido!")
			}
		}
	}

	funcao cadastrarMeta(){
		inteiro cat
		
		escreva("\nEm qual categoria deseja por a meta? \n1- Alimentação \n2 - Transporte \n3 - Moradia \n4 - Lazer \n=>")
		leia(cat)
		
		se (cat == 1){
			//mea pra alimentaﾃｧﾃ｣o
			definirMeta_Categoria(1)
			
		}senao se (cat == 2){
			//meta pra transporte 
			definirMeta_Categoria(2)
			
		}senao se (cat == 3){
			//meta pra moradia
			definirMeta_Categoria(3)
			
		}senao se (cat == 4){
			//meta pra lazer
			definirMeta_Categoria(4)
			
		}senao{
			escreva("\nfuncao cadastrarMeta(): opção de categoria inválida")
		}
		
	}

	funcao real porcentGastoAlimentacao(){
		//
		calcularDespesaTotal(dados_despesas)
		real porc_aliment = (dados_despesas[0]/despesa_total)*100

		retorne porc_aliment
	}

	funcao real porcentGastoTransporte(){
		//
		calcularDespesaTotal(dados_despesas)
		real porc_transporte = (dados_despesas[1]/despesa_total)*100

		retorne porc_transporte
	}

	funcao real porcentGastoMoradia(){
		//
		calcularDespesaTotal(dados_despesas)
		real porc_moradia = (dados_despesas[2]/despesa_total)*100

		retorne porc_moradia
	}

	funcao real porcentGastoLazer(){
		//
		calcularDespesaTotal(dados_despesas)
		real porc_lazer = (dados_despesas[3]/despesa_total)*100

		retorne porc_lazer
	}

	funcao cadeia porcentagensDeGastos(){
		retorne "\n------- Porcentagem de gastos -------"+
			   "\nALIMENTAÇÃO: R$ "+tp.real_para_cadeia(porcentGastoAlimentacao())+
			   "\nTRANSPORTE:  R$ "+tp.real_para_cadeia(porcentGastoTransporte())+
			   "\nMORADIA:     R$ "+tp.real_para_cadeia(porcentGastoMoradia())+
			   "\nLAZER:       R$ "+tp.real_para_cadeia(porcentGastoLazer())
	}
	///##############################################################################################################
	
	funcao inicio()
	{

	inteiro op = 0

	enquanto(op != -1){
		escreva(itensMenu())
		escreva("\n\nDigite sua opção \n=>")
		leia(op)

		se(op == 1){
			//registro de despesa e receita.			
			enquanto(op != -2){
				escreva("\n --------- Registros -----------")
				escreva("\n1 - Registro de Despesa")
				escreva("\n2 - Registro de Receita [depositar]")
				escreva("\n-2 - Sair do menu de Registros  \n=>")
				
				leia(op)

				se(op == 1){

					se (definiuMeta){

					escreva("\nAtuais metas de despesa: ")
					escreva("\n[ALIMENTAÇÃO]: "+verificarMetaAlimentacao())
					escreva("\n[TRANSPORTE]: "+verificarMetaTransporte())
					escreva("\n[MORADIA]: "+verificarMetaMoradia())
					escreva("\n[LAZER]: "+verificarMetaLazer())
					
					registrarDespesa()
					escreva("Despesa registrada com sucesso!")
					
					}senao{
						registrarDespesa()
						escreva("Despesa registrada com sucesso!")
					}
					
				} senao se (op == 2){
					registrarReceita()
					escreva("Depósito feito com sucesso!")
				}senao se(op == -2){
					escreva("Saindo do menu de Registros.")
				}senao{
					escreva("\nOpção não existe.")
				}
			}
		}

		senao se(op == 2){
			//calcular as despesas chamando cada mﾃｩtodo -> poupar memﾃｳria da mﾃ｡quina.
			calcularDespesaTotal(dados_despesas)
			
				escreva("\n---------- Extrato Bancﾃ｡rio Simplificado ----------")
				escreva("\nSaldo atual: R$", saldo)
				escreva("\nDespesas totais: R$", despesa_total)
				escreva("\n---------------------------------------------------")
				
				escreva("\n\n--------- Extrato Bancﾃ｡rio por Categoria ----------")
				escreva("\nGastos em [ALIMENTAﾃ�ﾃグ]: R$", dados_despesas[0])
				escreva("\nGastos em [TRANSPORTE]: R$", dados_despesas[1])
				escreva("\nGastos em [MORADIA]: R$", dados_despesas[2])
				escreva("\nGastos em [LAZER]: R$", dados_despesas[3])
				escreva("\n-----------------------------------------------------")

				//TODO: Adicionar as datas dos gastos.
		}

		senao se(op == 3){
			//TODO -> Definir Metas de Orﾃｧamento 

			enquanto(op != -3){
				escreva("\n---------- Metas de Orçamento ----------")
				escreva("\n1 - Definir/Alterar Metas")
				escreva("\n2 - Verificar metas")
				escreva("\n-3 - Sair \n=>")
				leia(op)
				
				se (op == 1){
					cadastrarMeta()
					escreva("\nMeta cadastrada com sucesso!")
					
				}senao se (op == 2){
					cadeia resp
					inteiro op_meta
					
					escreva("\nDeseja verificar alguma categoria específica? 's' para sim e 'n' para não \n=>")
					leia(resp)

					resp = txt.caixa_alta(resp)

					 se (resp == "N"){
					 	escreva("\nMostrando a meta de todas as categorias")
					 	escreva("\nMeta de [ALIMENTAÇÃO]: R$", meta_alimentacao)
					 	escreva("\nMeta de [TRANSPORTE]:  R$", meta_transporte)
					 	escreva("\nMeta de [MORADIA]:     R$", meta_moradia)
					 	escreva("\nMeta de [LAZER]:       R$", meta_lazer)
					 	
					 } senao se (resp == "S"){
					 	escreva("\nQual categoria deseja ver? \n1 - Alimentação \n2 - Transporte \n3 - Moradia \n4 - Lazer \n=>")
					 	leia(op_meta)

					 	se (op_meta == 1){
					 		//alimentação
					 	escreva("\n----------- META ALIMENTAÇÃO -------------")
					 	escreva("\n Valor da Meta: R$", meta_alimentacao)
					 	escreva("\nValor atualmente gasto na categoria: R$", dados_despesas[0])
					 	escreva("\n------------------------------------------")	
					 		
					 	} senao se(op_meta == 2){
					 		//transporte
					 	escreva("\n----------- META TRANSPORTE -------------")
					 	escreva("\n Valor da Meta: R$", meta_transporte)
					 	escreva("\nValor atualmente gasto na categoria: R$", dados_despesas[1])
					 	escreva("\n------------------------------------------")	
					 		
					 	}senao se(op_meta == 3){
					 		//moradia
					 	escreva("\n----------- META MORADIA -------------")
					 	escreva("\n Valor da Meta: R$", meta_moradia)
					 	escreva("\nValor atualmente gasto na categoria: R$", dados_despesas[2])
					 	escreva("\n------------------------------------------")	
					 		
					 		
					 	}senao se(op_meta == 4){
					 		//lazer
					 	escreva("\n----------- META LAZER -------------")
					 	escreva("\n Valor da Meta: R$", meta_lazer)
					 	escreva("\nValor atualmente gasto na categoria: R$", dados_despesas[3])
					 	escreva("\n------------------------------------------")	
					 		
					 		
					 	}senao{
					 		escreva("\nOpção inválida!")
					 	}
					 }
					
				}senao se (op == -3){
					escreva("Saindo do Menu de Metas de Orçamento...")
				}senao{
					escreva("\nOpção inválida")
				}
			}
		}

		senao se(op == 4){
			//Anﾃ｡lise de Tendﾃｪncia Financeira 

			enquanto(op != -4){
			escreva("\n---------- Anﾃ｡lise de Tendﾃｪncia Financeira --------")
			escreva("\n1 - Visualizar por categoria")
			escreva("\n2 - Visualizaﾃｧﾃ｣o geral")
			escreva("\n -4 Sair \n=>")
			leia(op)

			se(op == 1){

			inteiro op_meta
			
			escreva("\nQual categoria deseja ver? \n1 - Alimentaﾃｧﾃ｣o \n2 - Transporte \n3 - Moradia \n4 - Lazer \n -4 Sair\n=>")
			leia(op_meta)

			se (op_meta == 1){
			//alimentaﾃｧﾃ｣o
				escreva("\n----------- TENDﾃ劾CIA FINANCEIRA DE ALIMENTAﾃ�ﾃグ -------------")
				escreva("\nPorcentagem gasta na categoria [ALIMENTAﾃ�ﾃグ]: R$", porcentGastoAlimentacao())
				escreva("\n------------------------------------------")	
					 		
			} senao se(op_meta == 2){
			//transporte
				escreva("\n----------- TENDﾃ劾CIA FINANCEIRA DE TRANSPORTE -------------")
				escreva("\nPorcentagem gasta na categoria [TRANSPORTE]: R$", porcentGastoTransporte())
				escreva("\n------------------------------------------")	
					 		
			}senao se(op_meta == 3){
			//moradia
				escreva("\n----------- TENDﾃ劾CIA FINANCEIRA DE MORADIA -------------")
				escreva("\nPorcentagem gasta na categoria [MORADIA]: R$", porcentGastoMoradia())
				escreva("\n------------------------------------------")
					 		
					 		
			}senao se(op_meta == 4){
			//lazer
				escreva("\n----------- TENDﾃ劾CIA FINANCEIRA DE LAZER -------------")
				escreva("\nPorcentagem gasta na categoria [LAZER]: R$", porcentGastoLazer())
				escreva("\n------------------------------------------")	
					 		
			}senao se (op_meta == -4){
				escreva("\nSaindo do menu de tedﾃｪncias por categoria...")		 		
			
			}senao{
				escreva("\nOpﾃｧﾃ｣o invﾃ｡lida!")
			}
			
						
			}senao se(op == 2){
				escreva(porcentagensDeGastos())
				
			}senao se (op == -4){
				escreva("\nSaindo do menu de anﾃ｡lise de tendﾃｪncia financeira...")
			}senao{
				escreva("\nEssa opﾃｧﾃ｣o nﾃ｣o existe.")
			}
			
			}
		}
		senao se(op == -1){
			//Saﾃｭda do cﾃｳdigo
			escreva("Atﾃｩ a prﾃｳxima! ;)")
		}

		senao{
			escreva("\nOpﾃｧﾃ｣o nﾃ｣o existe.")
			limpa()
		}
	}
		
	}
}





/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 9568; 
 * @DOBRAMENTO-CODIGO = [27, 55, 81, 108, 135, 37, 169, 183, 190, 210, 206, 222, 238, 254, 309, 337, 345, 353, 361, 369, 427, 449, 523, 584, 589, 383];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */