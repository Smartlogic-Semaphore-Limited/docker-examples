
Progress Semaphore 5.8 example docker compose project.

In this version there is a new service called Concepts Service and Studio KMM service runs under Quarkus like all the rest of the studio services.

At the root of the OS version you plan to use (e.g. oraclelinux9), create a file called .env. This fill will contain username and password environment variables
for Marklogic and Semaphore.

For exmaple:

cd oraclelinux9
cat > .env
MARKLOGIC_ADMIN_USERNAME=MyAdminUser
MARKLOGIC_ADMIN_PASSWORD=MyPassword
MARKLOGIC_WALLET_PASSWORD=MyWalletPassword
SEMAPHORE_ADMIN_USERNAME=MyAdminUserForSemaphore
SEMAPHORE_ADMIN_PASSWORD=MyOtherPassword
(ctrl-d)
docker compose up -d

To stop:

docker compose stop

To tear down:

docker compose down -v --rmi local
