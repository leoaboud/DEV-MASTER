# 🚀 Dev-Master: Otimização & Manutenção Windows

<img width="800" height="200" alt="image" src="https://github.com/user-attachments/assets/20e5abe1-5f9f-4920-b793-7c9591bf68d7" />

---

Este projeto é uma ferramenta de automação via ficheiro de lotes (`.bat`) desenvolvida especificamente para o ecossistema windows . O objetivo é garantir que o hardware (especialmente **SSD**) e o ambiente de  trabalho funcionem sempre na performance máxima.

---

## 🔍 Como Identificar o Seu Hardware (SSD vs HDD)

Antes de realizar manutenções, deves saber que tipo de disco possuis, pois as técnicas de otimização são diferentes.

### Método Rápido (Interface Visual)
1. Pressiona `Win + R` no teclado.
2. Digita `dfrgui` e pressiona **Enter**.
3. Na coluna **Tipo de mídia**, verifica a descrição:
   - **Unidade de Estado Sólido:** É um **SSD**. (Otimização via TRIM).
   - **Disco Rígido:** É um **HDD**. (Otimização via Desfragmentação).

### Diferenças Técnicas no Windows
* **SSD:** Não deve ser desfragmentado (isso reduz a vida útil). O script utiliza o comando **TRIM**, que limpa blocos de dados inúteis no controlador do SSD.
* **HDD:** Os dados ficam espalhados fisicamente. O script organiza esses dados para que o braço mecânico do disco se mova menos, acelerando o sistema.

---

## 💻 Windows 10 vs Windows 11: O que muda?

| Funcionalidade | Windows 10 | Windows 11 |
| :--- | :--- | :--- |
| **Limpeza WinSxS** | Recupera espaço de atualizações antigas de forma estável. | Crucial para remover restos de builds e atualizações constantes. |
| **Widgets** | Pouco integrados. | Integrados no sistema. O script atualiza o `WebExperience Pack` para evitar lentidão. |
| **Interface** | Cache de ícones clássico. | Novo sistema de miniaturas que corrompe com mais facilidade. |
| **Performance** | Planos de energia equilibrados são suficientes. | Beneficia-se muito do modo "Desempenho Máximo" via `powercfg`. |

---

## 🛠️ Funcionalidades do Script (Os 11 Passos)

1.  **Limpeza de Cache de Sistema:** Remove dados temporários de aplicações para liberar memória.
2.  **Hygiene de Compilação:** Eliminação recursiva de pastas de cache de build e arquivos compilados que acumulam lixo no disco.
3.  **Arquivos Temporários:** Limpeza total das pastas `%TEMP%` e `Prefetch` do Windows.
4.  **WinSxS Cleanup:** Remoção de componentes obsoletos do Windows Update para recuperar gigabytes.
5.  **Thumbnail Cache Reset:** Reinicialização do cache de miniaturas e do *Explorer* para corrigir ícones corrompidos.
6.  **Widgets & Store Silent Update:** Atualização da infraestrutura de serviços via PowerShell sem abrir interfaces visuais.
7.  **Integridade do Sistema:** Execução do `DISM` e `SFC` em modo de verificação para garantir que o kernel do Windows não tem erros.
8.  **Otimização SSD (TRIM):** Comando vital para manter a saúde e a velocidade de escrita do SSD.
9.  **Package Manager Upgrade:** Atualização silenciosa de dependências essenciais do sistema via linha de comando.
10. **Reset de Rede & DNS:** Limpeza do cache DNS e reset dos protocolos *Winsock* para estabilizar a conexão.
11. **Energia e Logs:** Ativação do modo "Alto Desempenho", desativação da hibernação e limpeza final dos logs de eventos.

---

## ⚠️ Problemas Comuns & Soluções Detalhadas

### 1. Mensagem de "Acesso Negado"
* **Problema:** O script está a tentar alterar pastas protegidas do Windows sem ser Administrador.
* **Solução:** O script inclui um código de **Auto-Elevação**. Quando executares, o Windows pedirá autorização. **Clica em "Sim"**. Se o erro persistir, clica com o botão direito no ficheiro e escolhe **"Executar como Administrador"**.

### 2. "O arquivo já está sendo usado por outro processo"
* **Problema:** Estás a tentar apagar ficheiros temporários de programas que estão abertos no momento (ex: Chrome, VSCode).
* **Solução:** Isto é **normal**. O Windows não permite apagar ficheiros em uso para evitar que o sistema bloqueie. O script ignora estes ficheiros e continua com o resto da limpeza.

### 3. Travagem no Passo 7 (DISM / SFC)
* **Problema:** Este passo analisa a integridade de milhões de ficheiros. Pode parecer parado em 10% ou 20%.
* **Solução:** **Aguarde.** Em SSDs, demora entre 2 a 5 minutos. Em HDDs, pode demorar mais. Não feches a janela, pois interromper o processo pode deixar o sistema instável.

### 4. Erros de Codificação (`echo┬á`)
* **Problema:** O ficheiro `.bat` foi guardado como UTF-8 (padrão do VSCode ou editores modernos).
* **Solução:** Abre o ficheiro no Bloco de Notas, vai a **Ficheiro > Guardar Como** e altera a codificação para **ANSI**. Isto corrige todos os caracteres especiais no terminal.

---

## 📝 Instruções de Uso

1.  Copia o código do script.
2.  Abre o **Bloco de Notas**.
3.  Cola o código e guarda como `DevMaster.bat`.
4.  **Importante:** Garante que a codificação selecionada é **ANSI**.
5.  Executa o ficheiro e observa o progresso no terminal.
6.  O sistema irá desligar-se automaticamente após 30 segundos da conclusão para aplicar as alterações de rede e energia.
---

<img width="800" height="260" alt="image" src="https://github.com/user-attachments/assets/763ffa62-a564-4fb4-b479-b811d81486e0" />

---
*Documentação gerada para o fluxo de trabalho de um Developer de Alto Desempenho.*
