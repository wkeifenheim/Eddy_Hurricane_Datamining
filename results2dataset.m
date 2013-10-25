function results = results2dataset(results)

    categories = ['EddyType'; 'EddyLat '; 'EddyLon '; 'EddyAmp '; 'EddyU   '];
    categories = cellstr(categories);
    results = dataset({results(:,2:6),categories{:}});

end