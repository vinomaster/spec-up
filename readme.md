#  Trust over IP - Specification Template
This repo is a [GitHub Repo Template][1] for creating GitHub repositories within the ToIP GitHub Organization. Newly generated repos will contain all the necessary code for using Spec-Up for the development of [ToIP Deliverables][2].

The **ToIP Spec-Up Theme** is a ready-to-use customized version of [Spec-Up][3] that provides a ToIP branded environment for the development of technical specifications.

##

<p align="center">

<img src="./assets/default/logo.svg">

<h3 style="display: block; margin: 0 auto; text-align: center;">Markdown » Spec-Up</h3>

</p>

Spec-Up is a technical specification development tool that enables you to create rich specification documents for standards bodies and engineering projects by writing in an extended version of markdown that features all the bells and whistles - for example: advanced syntax highlighting, notice blocks, complex tables, charts, UML diagrams, and more.

## Purpose
This repo has been developed to address the [requirements](https://github.com/decentralized-identity/spec-up/issues/11) of [ToIP Foundation][5] contributors with respect to the [authoring process][6] for [ToIP Deliverables][2].

## Acknowledgements
This repo is derived from the fine work of Daniel Buchner and his [Spec Generator](https://github.com/decentralized-identity/spec-up) with [Express ](http://expressjs.com/) enhancements suggested by [Daniel N. Gisolfi](https://github.com/dgisolfi).

## Contributor's Guide
Once the new repo instance has been configured, Specification contributors should familiarize themselves with the [Contributor's Guide](https://github.com/trustoverip/spec-up/blob/main/DEV_README.md).

## Usage
The following instructions pertain to the initial configuration of a new repository instance that has been primed using the [trustoverip/spec-up GitHub Repo Template][12].

### Prime and clone a new repository
1. Generate a new repository from this template repository (see [GitHub docs][7]).
2. Clone the new repository (see [GitHub docs][8]).

### Pick a theme style
This repo supports the use of a *Specification* styled theme when the [ToIP Deliverable Type Indicator][9] is `TSS`. In all other cases, a contributors should consider using the ToIP themed repo for [MkDocs Material][4].

### Configure Spec-Up

In addition to the following instructions, please refer to the [Spec-Up Getting Started Guide](https://identity.foundation/spec-up/#getting-started).

1. Open the repository using your favorite IDE (i.e. [Visual Studio Code][10], [Atom][11]).
2. Edit the `specs.json` file.
3. Review the `specs[]` array. By default, this arrays contains three (3) samples:

    1. *Spec-Up Standalone Example*: Demonstration of how to use Spec-Up with a single standalone Markdown file, called `spec.md`.
    2. *Spec-Up Multi-File Example*: Demonstration of how to use Spec-Up with an array of  Markdown files.
    3. *ToIP TSS0000 SpecName*: A placeholder for a new ToIP Spec.
4. Modify the `specs[]` array, using a combination of options:

    1. Remove the Examples
    2. Keep the Examples
    3. Modify the TSS0000 entry
    4. Extend the array with another entry, as this repo can be used to serve more than one specification. This may be appropriate when a single TSS requires related or dependency specifications.

### Configure Express Server

This Spec-Up repo uses a Node Express Server to server the web-application.

1. Open the repository using your favorite IDE (i.e. [Visual Studio Code][10], [Atom][11]).
2. Edit the `server.js` file.
3. Update the `redirect` and web-site path information according to the specifications that will be hosted (as defined in `specs.json`). For indepth details on configuring an Express Server, please refer to the [Express API](http://expressjs.com/en/5x/api.html#res.sendFile).

### Configure Makefile

1. Open the repository using your favorite IDE (i.e. [Visual Studio Code][10], [Atom][11]).
2. Edit the `Makefile` file and find the variables depicted below:

    ```
    REPO_NAME ?= TSS0000-some-new-spec
    UPSTREAM_REPO ?= https://github.com/trustoverip/TSS0000-some-new-spec.git
    DEV_SITE_PORT ?= 7600
    SITE_DIR ?= spec_site/toip
    ```

3. Update the following settings:

    1. `REPO_NAME`: Provide the GitHub repository name.
    2. `UPSTREAM_REPO`: Set using the GitHub Repo Clone URL.
    3. `DEV_SITE_PORT`: Pick a port that will be used for the local test server: _https://localhost:8080_
    4. `SITE_DIR`: Use default or change relative path name for where the Markdown files for this new specification will be stored.

### Update Readme
1. Open the repository using your favorite IDE (i.e. [Visual Studio Code][10], [Atom][11]).
2. Based on the type of deliverable that will be associated with this new repo, copy the appropriate `template` from the [templates folder within the trustoverip/deliverables repo][15] to `./archive/SUGGESTED_OUTLINE.md`.
3. Move `README.md` to the `archive` folder. Rename it to `ORIGINAL_INSTRUCTIONS.md`.
4. Rename `DOC_README.md` to `README.md`
5. Update `README.md` accordingly.

    1. At the top of your file modify the _title_ so it is in the form:

        ```
        <TypeIndicator><4digitID>: Friendly Version of Your Title.
        ```

    2. Refer to the _Contribution Options_ of the [ToIP Deliverables Portal][14].


[1]: https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/creating-a-template-repository
[2]: https://github.com/trustoverip/deliverables/blob/master/_process/work_products.md
[3]: https://identity.foundation/spec-up/
[4]: https://github.com/trustoverip/mkdocs-material
[5]: https://trustoverip.org
[6]: https://trustoverip.github.io/deliverables/process/process_concepts/
[7]: https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template
[8]: https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/cloning-a-repository
[9]: https://trustoverip.github.io/deliverables/process/work_product_mgmt/#type-indicators
[10]: https://code.visualstudio.com/
[11]: https://atom.io
[12]: https://github.com/trustoverip/spec-up
[13]: https://en.wikipedia.org/wiki/YAML#:~:text=yaml.org,is%20being%20stored%20or%20transmitted.
[14]: https://trustoverip.github.io/deliverables/
[15]: https://github.com/trustoverip/deliverables/tree/master/templates
