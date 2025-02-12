[1mdiff --git a/.github/workflows/deploy.yml b/.github/workflows/deploy.yml[m
[1mnew file mode 100644[m
[1mindex 0000000..7dc5c34[m
[1m--- /dev/null[m
[1m+++ b/.github/workflows/deploy.yml[m
[36m@@ -0,0 +1,36 @@[m
[32m+[m[32mname: Deploy to AWS EC2[m
[32m+[m
[32m+[m[32mon:[m
[32m+[m[32m  push:[m
[32m+[m[32m    branches:[m
[32m+[m[32m      - main[m
[32m+[m
[32m+[m[32mjobs:[m
[32m+[m[32m  deploy:[m
[32m+[m[32m    name: Deploy to AWS EC2[m
[32m+[m[32m    runs-on: ubuntu-latest[m
[32m+[m
[32m+[m[32m    steps:[m
[32m+[m[32m      - name: Checkout repository[m
[32m+[m[32m        uses: actions/checkout@v4[m
[32m+[m
[32m+[m[32m      - name: Set up SSH[m
[32m+[m[32m        run: |[m
[32m+[m[32m          mkdir -p ~/.ssh[m
[32m+[m[32m          echo "${{ secrets.EC2_SSH_PRIVATE_KEY }}" > ~/.ssh/id_rsa[m
[32m+[m[32m          chmod 600 ~/.ssh/id_rsa[m
[32m+[m[32m          ssh-keyscan -H ${{ secrets.EC2_HOST }} >> ~/.ssh/known_hosts[m
[32m+[m
[32m+[m[32m      - name: Deploy on EC2[m
[32m+[m[32m        run: |[m
[32m+[m[32m          ssh ubuntu@${{ secrets.EC2_HOST }} << 'EOF'[m
[32m+[m[32m            # Pull the latest image[m
[32m+[m[32m            docker pull thormie/fastapi-app:latest[m
[32m+[m[41m            [m
[32m+[m[32m            # Stop & remove old container (if exists)[m
[32m+[m[32m            docker stop fastapi-container || true[m
[32m+[m[32m            docker rm fastapi-container || true[m
[32m+[m
[32m+[m[32m            # Run new container[m
[32m+[m[32m            docker run -d --name fastapi-container -p 80:8000 thormie/fastapi-app:latest[m
[32m+[m[32m          EOF[m
