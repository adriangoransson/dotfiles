if command -sq kubecolor
    function kubectl
        kubecolor $argv
    end
end

abbr --add k kubectl
