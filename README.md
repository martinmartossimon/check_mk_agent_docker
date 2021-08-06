# check_mk_agent_docker

Check_MK Agent Instance running on docker container.

# How to build the imagen?
Inside your cloned folder, run:

`docker build -t agente_check_mk -f ./Dockerfile .` 

All plugins inside plugin folder will be copied to check_mk_agent's plugin folder.


# How to run the instance?
`docker run --rm -p 6557:6556 -d --name check_mk_agent1 agente_check_mk`
