// This file contains your Data Connector logic
section pardot;


// Data Source Kind description
pardot = [
    Authentication = [
        //Key = [],
        UsernamePassword = [
			Label = "Pardot Authentication",
			UsernameLabel = "Email#user_key (EMAIL and USER_KEY seperated by '#')"		
		 ]
        // Windows = [],
        //Implicit = []
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
//api_domain = "http://localhost:9907";
api_domain = "https://pi.pardot.com";


pardot.Publish = [
    Beta = true,
    Category = "Pardot",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = pardot.Icons,
    SourceTypeImage = pardot.Icons
];
[DataSource.Kind="pardot", Publish="pardot.Publish"]
shared pardot.Contents = (#"Pardot Object Name" as text) =>
    let
        Credential = Extension.CurrentCredential(),
		split = Text.Split(Credential[Username],"#"),
		email = List.First(split),
		user_key = List.Last(split),
        token = TokenMethod(user_key, email, Credential[Password]),		     
		data = Web.Contents(Text.Format("#{0}/api/#{1}/version/3/do/query",{api_domain,#"Pardot Object Name"}),        
        [
            ManualCredentials = true,
			Query = [
                user_key = user_key,
                api_key = token,
                output="bulk"],
			Content = Text.ToBinary("") // to trigger HTTP POST       
        ]
        ),

        xmlTable= Xml.Tables(data,null,65001),
        containerTable = Table.FirstValue(xmlTable),
        objectsTable = Table.FirstValue(containerTable)


    in
        objectsTable;

TokenMethod = (user_key, email, password) =>
    let        
        Response = Web.Contents(Text.Format("#{0}/api/login/version/3",{api_domain}), [
            ManualCredentials = true,  
			Query = [email = email,password = password,user_key = user_key],
			Content = Text.ToBinary("") // to trigger HTTP POST
        ]),
      
        Parts = Xml.Tables(Response),          
        token = Parts{0}[api_key]

    in
        token;

pardot.Icons = [
    Icon16 = { Extension.Contents("pardot.dataconnector16.png"), Extension.Contents("pardot.dataconnector20.png"), Extension.Contents("pardot.dataconnector24.png"), Extension.Contents("pardot.dataconnector32.png") },
    Icon32 = { Extension.Contents("pardot.dataconnector32.png"), Extension.Contents("pardot.dataconnector40.png"), Extension.Contents("pardot.dataconnector48.png"), Extension.Contents("pardot.dataconnector64.png") }
];
