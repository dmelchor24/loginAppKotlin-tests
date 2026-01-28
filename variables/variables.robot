*** Settings ***
Library        AppiumLibrary

*** Variables ***
${REMOTE_URL}     http://localhost:4723
${USERNAME}    admin@test.com
${CONTRASENA}    123456

${platformName}           ${None}
${deviceName}             ${None}
${automationName}         ${None}
${appPackage}             ${None}
${appActivity}            ${None}
${avd}                    ${None}
${app}                    ${None}
${newCommandTimeout}      ${None}
${adbExecTimeout}         ${None}
${autoGrantPermissions}   ${None}
${noReset}                ${None}