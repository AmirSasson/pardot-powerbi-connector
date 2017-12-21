// This file contains your Data Connector logic
section pardot;


// Data Source Kind description
pardot = [
    Authentication = [
        //Key = [],
        UsernamePassword = []
        // Windows = [],
        //Implicit = []
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

//user_key = Text.FromBinary(Extension.Contents("user_key"));
// Data Source UI publishing description

pardot.Publish = [
    Beta = true,
    Category = "Pardot",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = pardot.Icons,
    SourceTypeImage = pardot.Icons
];
[DataSource.Kind="pardot", Publish="pardot.Publish"]
shared pardot.Contents = (objectName as text, user_key as text) =>
    let
        Credential = Extension.CurrentCredential(),
        token = TokenMethod(user_key),
        //content = Json.Document(Web.Contents(Text.Format("https://pi.pardot.com/api/#{0}/version/3/do/query",{objectName}),
        data = Web.Contents("http://localhost:9907/api/pardot/data",
        [
            ManualCredentials = true,
            Content = Text.ToBinary(Uri.BuildQueryString([
                email = Credential[Username],
                password = Credential[Password],
                api_key = token,
                output="bulk"]))            
        ]
        ),

        xmlTable= Xml.Tables(data,null,65001),
        containerTable = Table.FirstValue(xmlTable),
        objectsTable = Table.FirstValue(containerTable)


    in
        objectsTable;

TokenMethod = (user_key) =>
    let
        Credential = Extension.CurrentCredential(),
        //Response = Web.Contents("https://pi.pardot.com/api/login/version/3", [
        Response = Web.Contents("http://localhost:9907/api/pardot/token", [
            ManualCredentials = true,
            Content = Text.ToBinary(Uri.BuildQueryString([email = Credential[Username],password = Credential[Password],user_key = user_key]))            
        ]),
      
        Parts = Xml.Tables(Response),          
        token = Parts{0}[api_key]

    in
        token;

pardot.Icons = [
    Icon16 = { Extension.Contents("pardot.dataconnector16.png"), Extension.Contents("pardot.dataconnector20.png"), Extension.Contents("pardot.dataconnector24.png"), Extension.Contents("pardot.dataconnector32.png") },
    Icon32 = { Extension.Contents("pardot.dataconnector32.png"), Extension.Contents("pardot.dataconnector40.png"), Extension.Contents("pardot.dataconnector48.png"), Extension.Contents("pardot.dataconnector64.png") }
];
