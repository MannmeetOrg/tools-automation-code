- name: Configure GitHub Actions Runner
  hosts: all
  become: yes
  become_user: grunner
  vars:
  github_org: MannmeetOrg
  runner_name: "self-hosted-runner"
  github_token: $ {{ secrets.TOKEN_GITHUB }}
  runner_version: "2.307.1"

  tasks:
    - name: Obtain registration token
      uri:
      url: "https://api.github.com/orgs/{{ github_org }}/actions/runners/registration-token"
      method: POST
      headers:
      Authorization: "token {{ github_token }}"
      Accept: "application/vnd.github+json"
      X-GitHub-Api-Version: "2022-11-28"
      return_content: yes
      register: registration_token_response

    - name: Set the registration token fact
      set_fact:
      registration_token: "{{ registration_token_response.json.token }}"

    - name: Download GitHub Actions runner
      get_url:
      url: "https://github.com/actions/runner/releases/download/v{{ runner_version }}/actions-runner-linux-x64-{{ runner_version }}.tar.gz"
      dest: "/tmp/actions-runner.tar.gz"

    - name: Extract GitHub Actions runner
      unarchive:
      src: "/tmp/actions-runner.tar.gz"
      dest: "/home/runner/"
      remote_src: yes

    - name: Create runner service
      copy:
      dest: "/etc/systemd/system/actions.runner.service"
      content: |
      [Unit]
      Description=GitHub Actions Runner
      After=network.target

          [Service]
          WorkingDirectory=/home/runner/actions-runner
          ExecStart=/home/runner/actions-runner/runsvc.sh
          User=runner
          Restart=always
          RestartSec=10
          
          [Install]
          WantedBy=multi-user.target

    - name: Register GitHub Actions runner
      command: >
      /home/runner/actions-runner/config.sh --url https://github.com/{{ github_org }}
      --token {{ registration_token }} --name {{ runner_name }}
      args:
      creates: /home/runner/actions-runner/.runner

    - name: Start GitHub Actions runner service
      systemd:
      name: actions.runner
      state: started
      enabled: yes
