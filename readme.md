# RedCloud Tools Installer

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/yourusername/redcloud-tools/pulls)

> Um instalador simplificado para ferramentas de segurança em cloud, sem a necessidade de instalar todo o Red-Cloud-OS

## 📦 Instalação

```bash
git clone https://github.com/morteerror404/RedCloud-Tools/install_redcloud_tools.sh
cd redcloud-tools
chmod +x install_redcloud_tools.sh
./install_redcloud_tools.sh
```

## ✨ Recursos

- Instalação automatizada de +50 ferramentas de segurança cloud
- Organização por provedores (AWS, Azure, GCP, Multi-Cloud)
- Modo silencioso para automação
- Verificação de dependências
- Barra de progresso visual

## 🛠️ Como Usar

**Modo interativo:**
```bash
./install_redcloud_tools.sh
```

**Modo automático (instala tudo silenciosamente):**
```bash
./install_redcloud_tools.sh -a -s
```

**Opções disponíveis:**
```
-s, --silent    Modo silencioso (sem saída detalhada)
-a, --all       Instalar todas as ferramentas automaticamente
-h, --help      Mostrar ajuda
```

## 🗂️ Ferramentas Disponíveis

### ☁️ AWS (11 ferramentas)
- `AWSCLI` - Interface de linha de comando oficial da AWS
- `Pacu` - Framework de exploração de ambientes AWS
- `CloudMapper` - Mapeamento visual de infraestrutura AWS
- E mais...

### 🔷 Azure (15 ferramentas)
- `AzureHound` - Coleta de dados para análise de privilégios
- `MicroBurst` - Framework de avaliação de segurança Azure
- `ROADtools` - Ferramentas para interação com Azure AD
- E mais...

### 📊 GCP (9 ferramentas)
- `GCPBucketBrute` - Enumeração de buckets no Google Cloud
- `Hayat` - Framework de avaliação de segurança GCP
- `GCP-IAM-Collector` - Análise de permissões IAM
- E mais...

### 🌐 Multi-Cloud (16 ferramentas)
- `ScoutSuite` - Auditoria de segurança multi-cloud
- `Impacket` - Coleção de scripts para exploração de redes
- `Evilginx2` - Framework para phishing avançado
- E mais...

## 🤝 Contribuição
Contribuições são bem-vindas! Por favor:
1. Faça um fork do projeto
2. Crie sua branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request
