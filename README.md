# pardot-powerbi-connector
out of the box salesforce->paradot data connector.
Based on [PowerBI Custom connectors](https://github.com/Microsoft/DataConnectors).
Authenticate and queries the [Pardot Api](http://developer.pardot.com/#official-pardot-api-documentation) 

## Prerequisites
Data Connectors are created using the [M language](https://msdn.microsoft.com/library/mt211003.aspx). This is the same language used by the Power Query user experience found in Power BI Desktop and Excel 2016. Extensions allow you to define new functions for the M language, and can be used to enable connectivity to new data sources. While this document will focus on defining new connectors, much of the same process applies to defining general purpose M functions. Extensions can vary in complexity, from simple wrappers that essentially just provide "branding" over existing data source functions, to rich connectors that support Direct Query.

Please see the [Data Connector technical reference](docs/m-extensions.md) for more details.

## Quickstart

> **Note:** The steps to enable extensions changed in the June 2017 version of Power BI Desktop.

1. Install the [Power Query SDK](https://aka.ms/powerquerysdk) from the Visual Studio Marketplace
2. Clone this  project
3. Build the project to produce an extension file
4. Create a `[My Documents]\Microsoft Power BI Desktop\Custom Connectors` directory
5. Copy the extension file into this directory
6. Enable the **Custom data connectors** preview feature in Power BI Desktop (under *File | Options and settings | Custom data connectors*)
7. Restart Power BI Desktop


* [Power BI Desktop](https://www.microsoft.com/en-us/download/details.aspx?id=45331), May 2017 release or later
* [Power Query SDK for Visual Studio](https://aka.ms/powerquerysdk)
* [Fiddler](http://www.telerik.com/fiddler) - Optional, but recommended for viewing and debugging requests to your REST service

Reviewing the [M Extensibility documentation](../../docs/m-extensions.md) before starting this tutorial is highly recommended.

