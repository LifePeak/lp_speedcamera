

<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://discord.gg/G9zzDPvF4Y">
    <img src="https://i.imgur.com/kqu8Gp4.png" alt="Logo" width="180" height="180">
  </a>

  <h3 align="center">LifePeak - Skripts</h3>

  <p align="center">
    An awesome README template to jumpstart your projects!
    <br />
    <a href="https://lifepeak-scripts.tebex.io"><strong>Explore us on Tebex  »»</strong></a>
    <br />
    <br />
    <a href="https://www.youtube.com/channel/UC8tftArZtDQz_0bohnnidoA">View Demos</a>
    ·
    <a href="https://discord.gg/G9zzDPvF4Y">Report Bug</a>
    ·
    <a href="https://discord.gg/G9zzDPvF4Y">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS 
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>
-->


<!-- ABOUT THE PROJECT -->
## Explore Lifepeak
### What's Lifepeak-Scripts?
Lifepeak is a small developing team of three members. We are specialized in Five-M Scripting, Hosting, Managing Servers.






### What we offer ?

This section list our Supported Programming Languages and Frameworks.

### Programming Languages:
![C#](https://img.shields.io/badge/c%23-%23239120.svg?style=for-the-badge&logo=c-sharp&logoColor=white)
![C++](https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white)
![Go](https://img.shields.io/badge/go-%2300ADD8.svg?style=for-the-badge&logo=go&logoColor=white)
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=java&logoColor=white)
![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
![PHP](https://img.shields.io/badge/php-%23777BB4.svg?style=for-the-badge&logo=php&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

### Frameworks:
![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
![Laravel](https://img.shields.io/badge/laravel-%23FF2D20.svg?style=for-the-badge&logo=laravel&logoColor=white)
![Qt](https://img.shields.io/badge/Qt-%23217346.svg?style=for-the-badge&logo=Qt&logoColor=white)
![Bootstrap](https://img.shields.io/badge/bootstrap-%23563D7C.svg?style=for-the-badge&logo=bootstrap&logoColor=white)

--------------
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Which Platforms we're supporting?
We're currently supporting this platforms if you have any Questions regarding Linux or Windows feel free to contact us.

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)


## Interested? Find us on:

 * [![](https://img.shields.io/badge/Lifepeak-%237289DA.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/G9zzDPvF4Y)
 * [![](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](https://discord.gg/G9zzDPvF4Y)
 * [![](https://img.shields.io/badge/gitlab-%23181717.svg?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.lifepeak.de/lifepeak-freescripts)
 * [![](https://img.shields.io/badge/Google%20Chrome-4285F4?style=for-the-badge&logo=GoogleChrome&logoColor=yellow)](https://lifepeak.de/)

<!-- GETTING STARTED -->










# lp_speedcamera

lp_speedcamera is an simple all in one speedcamera system for fivem.
You can configurate Stationary and mobile speed cameras
You can lock/unlock and share your key with your frends.



### Installation

1. Download the Script at [Lifepeak-Gitlab](https://gitlab.lifepeak.de/lifepeak-freescripts/lp_speedcamera) and drag the lp_speedcamera folder into your resources folder.
2. Before you start you should read the config.lua and make changes if necessary.
   ```lua
   Config = {}
   Config.Locale = "de"
   Config.Billing = "none"                     -- Change your Billing System -> "esx_billing" / "okokBilling" / "none"
   Config.BillingAmount = 5                    -- Amount per Km/H
   Config.Society = "police"                   -- Billing Society / Create Speedcamera - Policejob
   Config.PolicePay = true                     -- Can police officers be fined true/false
   Config.CreateSpeedCamera = "spccreate"      -- Command to create a SpeedCamera
   Config.DeleteSpeedCamera = "spcdelete"      -- Command to delete a SpeedCamera
   -- Blips
   Config.Blips = {
    ShowBlip = true,                        -- Speedcamera Blips on Map
    BlipName = "Speedcamera",               -- Name for Blip
    BlipScale = 0.5,
    BlipColour = 2,
    BlipSprite = 184
    }
    -- Speedcameras
    Config.Locations = {
        [1] = {
            SpeedCameraName = "Highway Point",
            MaxKmH  = 130,
            Position = vector3(1437.810546875,752.94683837891,77.623649597168)
            },
        [2] = {
            SpeedCameraName = "Highway 23 South",
            MaxKmH  = 130,
            Position = vector3(-2485.4990234375,-218.81741333008,17.860759735107)
            }
    }
   
   ```
3. add the staring command to your server.cfg
   ```cfg
   start lp_carlock
   ```
It is recommended to use a billing system.
-> esx_billing
-> okokBilling
If you have any questions, contact the LifePeak team.
<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage to create / delete mobile speed camera
1. Type ```lua /spccreate SpeedCameraName MaxKmH  ``` create a new Mobile speed camera..
Type ```lua /spcdelete SpeedCameraName ``` to remove an existing Mobile speed camera..

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING 
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->
