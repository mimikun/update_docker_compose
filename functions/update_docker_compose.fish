function update_docker_compose --description 'Update docker-compose'
    echo "Update docker-compose?"
    if read_confirm
        set OLD_VERSION (docker-compose version --short)
        set VERSION (curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
        set DESTINATIONS "/usr/local/bin/docker-compose" "$HOME/.docker/cli-plugins/docker-compose"
        if test $OLD_VERSION != $VERSION
            echo "Update found!"
            sudo curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-(uname -s)-(uname -m) -o $DESTINATIONS[1]
            sudo cp $DESTINATIONS[1] $DESTINATIONS[2]
            sudo chmod 755 $DESTINATIONS[1]
            sudo chmod 755 $DESTINATIONS[2]
        else
            echo "No update required."
        end
    end
end
