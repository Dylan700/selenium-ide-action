docker build -t website-tester .; docker run -v /dev/shm:/dev/shm -v ./:/github/workspace/ --env GITHUB_WORKSPACE="/github/workspace/" --env BASE_URL="" website-tester