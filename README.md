# Treta Reader

Para modificar o frontend, não é necessário muito setup. Há uma rota criada para
que não seja necessário o acesso a nenhuma API (Twitter ou AWS):

http://localhost:3000/threads/sample

Já para modificar qualquer coisa em como os tweets são buscados, o setup é mais
complexo:

- As threads ficam guardadas num bucket da AWS S3, para que não seja
necessário nenhum banco de dados. Essa parte, no entando, pode ser pulada abrindo
o servidor com a variável de ambiente SKIP_S3. `SKIP_S3=1 rails server`;
- Já pra acessar a API do Twitter, não sei bem como fazer.