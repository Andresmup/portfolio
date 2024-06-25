// Skills icons - https://icon-sets.iconify.design/
import { Icon } from "@iconify/react";

// Navbar Logo image (uncomment below and import your image)
// import newLogo from "./images/yourFileName"

// Projects Images (add your images to the images directory and import below)
import Logo from "./images/logo.svg";

// Hero Images (add your images to the /images directory with the same names)
import HeroLight from "./images/hero-light.jpg";
import HeroDark from "./images/hero-dark.jpg";
// If you change the import names above then you need to change the export names below
export { HeroLight as Light };
export { HeroDark as Dark };

/* START HERE
 **************************************************************
  Add your GitHub username (string - "Andresmup") below.
*/
export const githubUsername = "Andresmup";

// Navbar Logo image
export const navLogo = undefined;

// Blog link icon - https://icon-sets.iconify.design/
export const Blog = <Icon icon="mdi:linkedin" />;

/* About Me
 **************************************************************
  Add a second paragraph for the about me section.
*/
export const moreInfo =
  "Status = 'Using data on the AWS cloud'";

/* Skills
 ************************************************************** 
  Add or remove skills in the SAME format below, choose icons here - https://icon-sets.iconify.design/
*/
export const skillData = [
  {
    id: 1,
    skill: <Icon icon="simple-icons:python" className="display-4" />,
    name: "Python",
  },
  {
    id: 2,
    skill: <Icon icon="carbon:sql" className="display-4" />,
    name: "Sql",
  },
  {
    id: 3,
    skill: <Icon icon="simple-icons:pytorch" className="display-4" />,
    name: "Pytorch",
  },
  {
    id: 4,
    skill: <Icon icon="la:aws" className="display-4" />,
    name: "AWS",
  },
  {
    id: 5,
    skill: <Icon icon="simple-icons:googlecloud" className="display-4" />,
    name: "GCP",
  },
  {
    id: 6,
    skill: <Icon icon="mdi:terraform" className="display-4" />,
    name: "Terraform",
  },
  {
    id: 7,
    skill: <Icon icon="cib:apache-spark" className="display-4" />,
    name: "Spark",
  },
  {
    id: 8,
    skill: <Icon icon="mdi:apache-kafka" className="display-4" />,
    name: "Kafka",
  },
  {
    id: 9,
    skill: <Icon icon="simple-icons:dbt" className="display-4" />,
    name: "DBT",
  },
  {
    id: 10,
    skill: <Icon icon="simple-icons:powerbi" className="display-4" />,
    name: "PowerBi",
  },
  {
    id: 11,
    skill: <Icon icon="simple-icons:googlebigquery" className="display-4" />,
    name: "BigQuey",
  },
  {
    id: 12,
    skill: <Icon icon="simple-icons:looker" className="display-4" />,
    name: "Looker",
  },
  {
    id: 13,
    skill: <Icon icon="tabler:lambda" className="display-4" />,
    name: "Lambda",
  },
  {
    id: 14,
    skill: <Icon icon="cib:apache-airflow" className="display-4" />,
    name: "Airflow",
  },
  {
    id: 15,
    skill: <Icon icon="fluent-emoji-high-contrast:man-mage" className="display-4" />,
    name: "Mage",
  },
  {
    id: 16,
    skill: <Icon icon="mdi:docker" className="display-4" />,
    name: "Docker",
  },
  {
    id: 17,
    skill: <Icon icon="bi:git" className="display-4" />,
    name: "Git",
  },
  {
    id: 18,
    skill: <Icon icon="fa6-brands:square-github" className="display-4" />,
    name: "GitHub",
  },
];

// Resume link (string - "https://YourResumeUrl") - I am using CloudFront to share my resume (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)
export const resume = null;

/* Projects
 ************************************************************** 
  List the repo names (string - "your-repo-name") you want to include (they will be sorted alphabetically). If empty, only the first 3 will be included.
*/
export const filteredProjects = ["Mage_Pipeline_S3_to_RDS", "Lambda_Function_Container-AutoUpdate_Actions", "PyTorch_Arquitecture_Comparison "];

// Replace the defualt GitHub image for matching repos below (images imported above - lines 7-8)
export const projectCardImages = [
  {
    name: "example-1",
    image: Logo,
  },
];

/* Contact Info
 ************************************************************** 
  Add your formspree endpoint below.
  https://formspree.io/
*/
export const formspreeUrl = "https://formspree.io/f/YourEndpoint";
